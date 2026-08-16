package com.cravio.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cravio.entity.Address;

public interface AddressRepo extends JpaRepository<Address, Integer> {

    // All addresses saved by one user, for the profile "Addresses" tab
    List<Address> findByUserId(Integer userId);

    // Used before setting a new default, so only one address per user
    // is ever marked default at a time.
    @Modifying
    @Query("UPDATE Address a SET a.isDefault = false WHERE a.user.id = :userId")
    void clearDefaultForUser(@Param("userId") Integer userId);
}
