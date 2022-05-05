CREATE DATABASE cars4all;
USE cars4all;
drop database cars4all;

CREATE TABLE repairShop (
    repid CHAR(4) PRIMARY KEY,
    `name` VARCHAR(50),
    address VARCHAR(50),
    zip_code VARCHAR(10),
    state CHAR(2),
    license VARCHAR(50),
    phone VARCHAR(25),
    email VARCHAR(50),
    subscriptionEndsOn DATE
);
CREATE TABLE vendor (
    vendid CHAR(4) PRIMARY KEY,
    `name` VARCHAR(50),
    address VARCHAR(50),
    zip_code VARCHAR(10),
    state CHAR(2),
    license VARCHAR(50),
    phone VARCHAR(25),
    email VARCHAR(50),
    subscriptionEndsOn DATE
);
CREATE TABLE provider (
    providerid CHAR(4) PRIMARY KEY,
    `name` VARCHAR(50),
    address VARCHAR(50),
    zip_code VARCHAR(10),
    state CHAR(2),
    phone VARCHAR(25),
    email VARCHAR(50)
);
CREATE TABLE paymentCard (
    cardid CHAR(5) PRIMARY KEY,
    nameOnCard VARCHAR(25),
    card_type VARCHAR(25),
    card_number VARCHAR(25),
    expiration_date DATE,
    card_security_number VARCHAR(10),
    zip_code VARCHAR(10)
);
/*--------------------------------------------------------DATASET STARTS-----------------------------------------------------------------------*/
-- Table structure for table `parts`
DROP 
  TABLE IF EXISTS `parts`;
CREATE TABLE `parts` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `ts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `title` VARCHAR(255) COLLATE UTF8_UNICODE_CI NOT NULL,
    `_yf_slug` VARCHAR(255) COLLATE UTF8_UNICODE_CI NOT NULL,
    `product` VARCHAR(255) COLLATE UTF8_UNICODE_CI NOT NULL,
    `product_description` VARCHAR(255) COLLATE UTF8_UNICODE_CI NOT NULL,
    `cond` VARCHAR(255) COLLATE UTF8_UNICODE_CI NOT NULL,
    `stock_ref` VARCHAR(255) COLLATE UTF8_UNICODE_CI NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `title` (`title` , `_yf_slug`),
    KEY `ts` (`ts`),
    KEY `_yf_slug` (`_yf_slug`)
)  ENGINE=INNODB AUTO_INCREMENT=5445 DEFAULT CHARSET=UTF8 COLLATE = UTF8_UNICODE_CI;
/*--------------------------------------------------------DATASET ENDS-------------------------------------------------------------------------*/
CREATE TABLE stock (
    vendid CHAR(4),
    partid BIGINT(20) UNSIGNED,
    price DECIMAL(13 , 2 ),
    quantity INT,
    PRIMARY KEY (vendid , partid, price),
    CONSTRAINT fk_stock_vendor_venid FOREIGN KEY (vendid)
        REFERENCES vendor (vendid),
    CONSTRAINT fk_stock_parts_partsid FOREIGN KEY (partid)
        REFERENCES parts (id)
);
CREATE TABLE cart (
    cartid INT PRIMARY KEY,
    repid CHAR(4),
    cart_date DATE,
    CONSTRAINT fk_cart_repairshop_repid FOREIGN KEY (repid)
        REFERENCES repairShop (repid)
);
CREATE TABLE cartItem (
    cartitemid INT PRIMARY KEY,
    cartid INT,
    partid BIGINT(20) UNSIGNED,
    quantity INT,
    price DECIMAL(13 , 2 ),
    vendid CHAR(4),
    CONSTRAINT fk_cartItem_cart_cartid FOREIGN KEY (cartid)
        REFERENCES cart (cartid),
    CONSTRAINT fk_cartItem_parts_id FOREIGN KEY (partid)
        REFERENCES parts (id),
    CONSTRAINT fk_cartItem_vendor_vendid FOREIGN KEY (vendid)
        REFERENCES vendor (vendid)
);
CREATE TABLE `order` (
    orderid INT PRIMARY KEY,
    repid CHAR(4),
    subtotal DECIMAL(13 , 2 ),
    totaltax DECIMAL(13 , 2 ),
    totalshippingfee DECIMAL(13 , 2 ),
    ordertotal DECIMAL(13 , 2 ),
    CONSTRAINT fk_order_repairshop_repid FOREIGN KEY (repid)
        REFERENCES repairshop (repid)
);
CREATE TABLE orderItem (
    orderitemid INT PRIMARY KEY,
    orderid INT,
    vendid CHAR(4),
	partid BIGINT(20) UNSIGNED,
    quantity INT,
    priceperunit DECIMAL(13 , 2 ),
    subtotal DECIMAL(13 , 2 ),
    tax DECIMAL(13 , 2 ),
    shippingfee DECIMAL(13 , 2 ),
    grandtotal DECIMAL(13 , 2 ),
    CONSTRAINT fk_orderItem_parts_id FOREIGN KEY (partid)
        REFERENCES parts (id),
    CONSTRAINT fk_orderItem_order_orderid FOREIGN KEY (orderid)
        REFERENCES `order` (orderid),
    CONSTRAINT fk_orderItem_vendor_vendid FOREIGN KEY (vendid)
        REFERENCES vendor (vendid)
);
CREATE TABLE shipment (
    shipid INT PRIMARY KEY,
    providerid CHAR(4),
    orderitemid INT,
    shipdate DATE,
    shiptracklink VARCHAR(100),
    deliverydate DATE,
    deliverymode VARCHAR(16),
    deliveryaddress VARCHAR(50),
    deliveryzipcode VARCHAR(10),
    deliverystate CHAR(2),
    CONSTRAINT fk_shipment_provider_providerid FOREIGN KEY (providerid)
        REFERENCES provider (providerid),
    CONSTRAINT fk_shipment_orderitem_orderitemid FOREIGN KEY (orderitemid)
        REFERENCES orderitem (orderitemid)
);
CREATE TABLE payment (
    pmtid INT PRIMARY KEY,
    cardid CHAR(5),
    orderitemid INT,
    vendid CHAR(4),
    paymentdate DATE,
    paymenttype VARCHAR(16),
    paymentstatus VARCHAR(16),
    grandtotal DECIMAL(13 , 2 ),
    CONSTRAINT fk_payment_paymentCard_cardid FOREIGN KEY (cardid)
        REFERENCES paymentCard (cardid),
    CONSTRAINT fk_payment_orderitem_orderitemid FOREIGN KEY (orderitemid)
        REFERENCES orderitem (orderitemid),
    CONSTRAINT fk_payment_vendor_vendid FOREIGN KEY (vendid)
        REFERENCES vendor (vendid)
);
