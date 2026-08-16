package com.cravio.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

// NEW ENTITY — backs the "Saved Addresses" tab in profile-modal.jsp,
// which today only writes to localStorage (cravio_user_addresses).
@Entity
@Table(name = "addresses")
@Getter
@Setter
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "tag", length = 20)
    private String tag; // HOME, WORK, OTHER — matches addrFormTag in profile-modal.jsp

    @Column(name = "title", nullable = false, length = 100)
    private String title;

    @Column(name = "street", nullable = false, length = 255)
    private String street;

    @Column(name = "city", nullable = false, length = 100)
    private String city;

    @Column(name = "zipcode", nullable = false, length = 20)
    private String zipcode;

    @Column(name = "is_default")
    private Boolean isDefault;
}
