package com.cravio.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cravio.controller.CravioController.AddressRequest;
import com.cravio.entity.Address;
import com.cravio.entity.User;
import com.cravio.repository.AddressRepo;
import com.cravio.repository.UserRepo;

@Service
public class AddressService {

    @Autowired
    private AddressRepo addressRepo;

    @Autowired
    private UserRepo userRepo;

    public List<Address> getAddressesForUser(Integer userId) {
        return addressRepo.findByUserId(userId);
    }

    @Transactional
    public Address addAddress(Integer userId, AddressRequest req) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        validate(req);

        boolean isFirstAddress = addressRepo.findByUserId(userId).isEmpty();
        boolean makeDefault = Boolean.TRUE.equals(req.getIsDefault()) || isFirstAddress;

        if (makeDefault) {
            addressRepo.clearDefaultForUser(userId);
        }

        Address address = new Address();
        address.setUser(user);
        address.setTag(req.getTag());
        address.setTitle(req.getTitle());
        address.setStreet(req.getStreet());
        address.setCity(req.getCity());
        address.setZipcode(req.getZipcode());
        address.setIsDefault(makeDefault);

        return addressRepo.save(address);
    }

    @Transactional
    public Address updateAddress(Integer addressId, Integer userId, AddressRequest req) {
        Address address = getOwnedAddress(addressId, userId);
        validate(req);

        if (Boolean.TRUE.equals(req.getIsDefault())) {
            addressRepo.clearDefaultForUser(userId);
            address.setIsDefault(true);
        }

        address.setTag(req.getTag());
        address.setTitle(req.getTitle());
        address.setStreet(req.getStreet());
        address.setCity(req.getCity());
        address.setZipcode(req.getZipcode());

        return addressRepo.save(address);
    }

    @Transactional
    public void deleteAddress(Integer addressId, Integer userId) {
        Address address = getOwnedAddress(addressId, userId);
        boolean wasDefault = Boolean.TRUE.equals(address.getIsDefault());
        addressRepo.delete(address);

        // If the deleted address was the default one, promote another
        // remaining address so the user is never left with zero defaults.
        if (wasDefault) {
            List<Address> remaining = addressRepo.findByUserId(userId);
            if (!remaining.isEmpty()) {
                Address next = remaining.get(0);
                next.setIsDefault(true);
                addressRepo.save(next);
            }
        }
    }

    @Transactional
    public void setDefaultAddress(Integer addressId, Integer userId) {
        Address address = getOwnedAddress(addressId, userId);
        addressRepo.clearDefaultForUser(userId);
        address.setIsDefault(true);
        addressRepo.save(address);
    }

    // Fetches the address AND verifies it belongs to the requesting user.
    // Prevents user A from editing/deleting/deleting user B's saved address
    // just by guessing an address ID.
    private Address getOwnedAddress(Integer addressId, Integer userId) {
        Address address = addressRepo.findById(addressId)
                .orElseThrow(() -> new RuntimeException("Address not found"));
        if (!address.getUser().getId().equals(userId)) {
            throw new RuntimeException("Address not found or access denied");
        }
        return address;
    }

    private void validate(AddressRequest req) {
        if (isBlank(req.getTitle()) || isBlank(req.getStreet())
                || isBlank(req.getCity()) || isBlank(req.getZipcode())) {
            throw new RuntimeException("Please fill all address fields");
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
