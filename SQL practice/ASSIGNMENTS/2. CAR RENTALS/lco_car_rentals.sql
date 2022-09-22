
  1
  2
  3
  4
  5
  6
  7
  8
  9
 10
 11
 12
 13
 14
 15
 16
 17
 18
 19
 20
 21
 22
 23
 24
 25
 26
 27
 28
 29
 30
 31
 32
 33
 34
 35
 36
 37
 38
 39
 40
 41
 42
 43
 44
 45
 46
 47
 48
 49
 50
 51
 52
 53
 54
 55
 56
 57
 58
 59
 60
 61
 62
 63
 64
 65
 66
 67
 68
 69
 70
 71
 72
 73
 74
 75
 76
 77
 78
 79
 80
 81
 82
 83
 84
 85
 86
 87
 88
 89
 90
 91
 92
 93
 94
 95
 96
 97
 98
 99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
285
286
287
288
289
290
291
292
293
294
295
296
297
298
299
300
301
302
303
304
305
306
307
308
309
310
311
312
313
314
315
316
317
318
319
320
321
322
323
324
325
326
327
328
329
330
331
332
333
334
335
336
337
338
339
340
341
342
343
344
345
346
347
348
349
350
351
352
353
354
355
356
357
358
359
360
361
362
363
364
365
366
367
368
369
370
371
372
373
374
375
376
377
378
379
380
381
382
383
384
385
386
387
388
389
390
391
392
393
394
395
396
397
398
399
400
401
402
403
404
405
406
407
408
409
410
411
412
413
414
415
416
417
418
419
420
421
422
423
424
425
426
427
428
429
430
431
432
433
434
435
436
437
438
439
440
441
442
443
444
445
446
447
448
449
450
451
452
453
454
455
456
457
458
459
460
461
462
463
464
465
466
467
468
469
470
471
472
473
474
475
476
477
478
479
480
481
482
483
484
485
486
487
488
489
490
491
492
493
494
495
496
497
498
499
500
501
502
503
504
505
506
507
508
509
510
511
512
513
514
515
516
517
518
519
520
521
522
523
524
525
526
527
528
529
530
531
532
533
534
535
536
537
538
539
540
541
542
543
544
545
546
547
548
549
550
551
552
553
554
555
556
557
558
559
560
561
562
563
564
565
566
567
568
569
570
-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 01, 2020 at 07:50 AM
-- Server version: 10.1.40-MariaDB
-- PHP Version: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lco_car_rentals`
--
DROP DATABASE IF EXISTS `lco_car_rentals` ;
CREATE DATABASE IF NOT EXISTS `lco_car_rentals` DEFAULT CHARACTER SET utf8 ;
USE `lco_car_rentals` ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `dob` date NOT NULL,
  `driver_license_number` varchar(12) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `first_name`, `last_name`, `dob`, `driver_license_number`, `email`, `phone`) VALUES
(1, 'Kelby', 'Matterdace', '1974-05-22', 'V435899293', 'kmatterdace0@oracle.com', '181-441-7828'),
(2, 'Orion', 'De Hooge', '1992-08-07', 'Z140530509', 'odehooge1@quantcast.com', '948-294-5458'),
(3, 'Sheena', 'Macias', '1981-03-10', 'W045654959', 'smacias3@amazonaws.com', NULL),
(4, 'Irving', 'Packe', '1994-12-19', 'O232196823', 'ipacke4@cbc.ca', '157-815-8064'),
(5, 'Kass', 'Humphris', '1993-12-16', 'G055017319', 'khumphris5@xrea.com', '510-624-4189');

--
-- Triggers `customer`
--
DELIMITER $$
CREATE TRIGGER `age_check` BEFORE INSERT ON `customer` FOR EACH ROW BEGIN
DECLARE age INT UNSIGNED;
SELECT TIMESTAMPDIFF(YEAR, new.dob, CURDATE()) INTO age FROM DUAL;
    IF (age < 21) THEN
    SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'customer age_check constraint on customer.dob failed';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` int(11)  NOT NULL,
  `name` varchar(45) NOT NULL,
  `equipment_type_id` int(11) UNSIGNED NOT NULL,
  `current_location_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `name`, `equipment_type_id`, `current_location_id`) VALUES
(1, 'Garmin GPS', 1, 5),
(2, 'Tomtom GPS', 1, 6),
(3, 'Tomtom GPS', 1, 7),
(4, 'Infant Child Seat', 3, 1),
(5, 'Child Seat', 3, 7),
(6, 'Booster Seat', 3, 1),
(7, 'Sirius XM Satellite Radio', 2, 5),
(8, 'Sirius XM Satellite Radio', 2, 6);

-- --------------------------------------------------------

--
-- Table structure for table `equipment_type`
--

CREATE TABLE `equipment_type` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `rental_value` decimal(13,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `equipment_type`
--

INSERT INTO `equipment_type` (`id`, `name`, `rental_value`) VALUES
(1, 'GPS', '14.99'),
(2, 'Satellite Radio', '7.99'),
(3, 'Child Safety Seats', '13.99');

-- --------------------------------------------------------

--
-- Table structure for table `fuel_option`
--

CREATE TABLE `fuel_option` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fuel_option`
--

INSERT INTO `fuel_option` (`id`, `name`, `description`) VALUES
(1, 'Pre-pay', 'Customer pays in advance for a full tank of fuel, so they can return back with an empty tank of fuel, without the hassle of last minute stops and purchasing the fuel.'),
(2, 'Self-Service', 'Customer will get full tank of fuel with the rental car and must return it back with the full tank of fuel.'),
(3, 'Market', 'Customer gets the car with full tank of fuel but pays for fuel at market price based on fuel usage.  ');

-- --------------------------------------------------------

--
-- Table structure for table `insurance`
--

CREATE TABLE `insurance` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `cost` decimal(13,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `insurance`
--

INSERT INTO `insurance` (`id`, `name`, `cost`) VALUES
(1, 'Cover The Car (LDW)', '30.99'),
(2, 'Cover Myself (PAI)', '7.00'),
(3, 'Cover My Belongings (PEP)', '2.95'),
(4, 'Cover My Liability (ALI)', '16.50');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `id` int(11) NOT NULL,
  `street_address` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zipcode` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `street_address`, `city`, `state`, `zipcode`) VALUES
(1, '1001 Henderson St', 'Fort Worth', 'TX', 76102),
(2, '300 Reunion Blvd', 'Dallas', 'TX', 75207),
(3, '5911 Blair Rd NW', 'Washington', 'DC', 20011),
(4, '9217 Airport Blvd', 'Los Angeles', 'CA', 90045),
(5, '310 E 64th St', 'New York', 'NY', 10021),
(6, '1011 Pike St', 'Seattle', 'WA', 98101),
(7, '5150 W 55th St', 'Chicago', 'IL', 60638);

-- --------------------------------------------------------

--
-- Table structure for table `rental`
--

CREATE TABLE `rental` (
  `id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `customer_id` int(11) UNSIGNED NOT NULL,
  `vehicle_type_id` int(11) UNSIGNED NOT NULL,
  `fuel_option_id` int(11) UNSIGNED NOT NULL,
  `pickup_location_id` int(11) UNSIGNED NOT NULL,
  `drop_off_location_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rental`
--

INSERT INTO `rental` (`id`, `start_date`, `end_date`, `customer_id`, `vehicle_type_id`, `fuel_option_id`, `pickup_location_id`, `drop_off_location_id`) VALUES
(1, '2018-07-14', '2018-07-23', 1, 2, 1, 3, 5),
(2, '2018-07-10', '2018-07-12', 2, 1, 2, 1, 2),
(3, '2018-06-30', '2018-07-20', 3, 1, 3, 4, 6),
(4, '2018-06-10', '2018-07-02', 4, 4, 2, 2, 7),
(5, '2018-07-14', '2018-07-27', 5, 3, 3, 5, 3);

-- --------------------------------------------------------

--
-- Table structure for table `rental_has_equipment_type`
--

CREATE TABLE `rental_has_equipment_type` (
  `rental_id` int(11) UNSIGNED NOT NULL,
  `equipment_type_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rental_has_equipment_type`
--

INSERT INTO `rental_has_equipment_type` (`rental_id`, `equipment_type_id`) VALUES
(1, 1),
(1, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 3);

-- --------------------------------------------------------

--
-- Table structure for table `rental_has_insurance`
--

CREATE TABLE `rental_has_insurance` (
  `rental_id` int(11) UNSIGNED NOT NULL,
  `insurance_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rental_has_insurance`
--

INSERT INTO `rental_has_insurance` (`rental_id`, `insurance_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4),
(3, 1),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `rental_invoice`
--

CREATE TABLE `rental_invoice` (
  `id` int(10) UNSIGNED NOT NULL,
  `car_rent` decimal(13,2) UNSIGNED NOT NULL,
  `equipment_rent_total` decimal(13,2) UNSIGNED DEFAULT NULL,
  `insurance_cost_total` decimal(13,2) UNSIGNED DEFAULT NULL,
  `tax_surcharges_and_fees` decimal(13,2) UNSIGNED NOT NULL,
  `total_amount_payable` decimal(13,2) UNSIGNED NOT NULL,
  `discount_amount` decimal(13,2) UNSIGNED DEFAULT NULL,
  `net_amount_payable` decimal(13,2) UNSIGNED NOT NULL,
  `rental_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rental_invoice`
--

INSERT INTO `rental_invoice` (`id`, `car_rent`, `equipment_rent_total`, `insurance_cost_total`, `tax_surcharges_and_fees`, `total_amount_payable`, `discount_amount`, `net_amount_payable`, `rental_id`) VALUES
(1, '265.05', '206.82', '368.46', '73.99', '914.32', '79.52', '834.81', 1),
(2, '53.54', '0.00', '94.98', '23.22', '171.74', '0.00', '171.74', 2),
(3, '535.40', '459.60', '619.80', '169.98', '1784.78', '160.62', '1624.16', 3),
(4, '824.56', '637.56', '1263.68', '503.34', '3229.14', '274.37', '2981.77', 4),
(5, '452.53', '0.00', '402.87', '234.76', '1090.16', '135.76', '954.40', 5);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `id` int(11) NOT NULL,
  `brand` varchar(45) NOT NULL,
  `model` varchar(45) NOT NULL,
  `model_year` year(4) NOT NULL,
  `mileage` int(9) NOT NULL,
  `color` varchar(45) NOT NULL,
  `vehicle_type_id` int(11) UNSIGNED NOT NULL,
  `current_location_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`id`, `brand`, `model`, `model_year`, `mileage`, `color`, `vehicle_type_id`, `current_location_id`) VALUES
(1, 'Nissan', 'Versa', 2016, 65956, 'white', 1, 1),
(2, 'Mitsubishi', 'Mirage', 2017, 55864, 'light blue', 1, 6),
(3, 'Chevrolet', 'Cruze', 2017, 45796, 'dark gray', 2, 5),
(4, 'Hyundai', 'Elantra', 2018, 35479, 'black', 2, 1),
(5, 'Volkswagen', 'Jetta', 2019, 2032, 'light gray', 3, 3),
(6, 'Toyota', 'RAV4', 2018, 12566, 'white', 4, 7);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_has_equiment`
--

CREATE TABLE `vehicle_has_equiment` (
  `equipment_id` int(11) UNSIGNED NOT NULL,
  `vehicle_id` int(11) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vehicle_has_equiment`
--

INSERT INTO `vehicle_has_equiment` (`equipment_id`, `vehicle_id`, `start_date`, `end_date`) VALUES
(1, 3, '2018-07-14', '2018-07-23'),
(2, 2, '2018-06-15', '2018-07-20'),
(3, 6, '2018-06-09', '2018-07-02'),
(5, 6, '2018-06-09', '2018-07-02'),
(7, 3, '2018-07-14', '2018-07-23'),
(8, 2, '2018-06-15', '2018-07-20');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_type`
--

CREATE TABLE `vehicle_type` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `rental_value` decimal(13,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vehicle_type`
--

INSERT INTO `vehicle_type` (`id`, `name`, `rental_value`) VALUES
(1, 'Economy', '26.77'),
(2, 'Intermediate', '29.45'),
(3, 'Standard', '34.81'),
(4, 'Economy SUV', '37.48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`) ,
  ADD UNIQUE KEY `driver_license_number_UNIQUE` (`driver_license_number`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_equipment_equipment_type` (`equipment_type_id`),
  ADD KEY `fk_equipment_location` (`current_location_id`);

--
-- Indexes for table `equipment_type`
--
ALTER TABLE `equipment_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fuel_option`
--
ALTER TABLE `fuel_option`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `insurance`
--
ALTER TABLE `insurance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `zipcode_UNIQUE` (`zipcode`);

--
-- Indexes for table `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_rental_customer_idx` (`customer_id`),
  ADD KEY `fk_rental_fuel_option_idx` (`fuel_option_id`),
  ADD KEY `fk_rental_pickup_location_idx` (`pickup_location_id`),
  ADD KEY `fk_rental_dropoff_location_idx` (`drop_off_location_id`),
  ADD KEY `fk_rental_vehicle_type_idx` (`vehicle_type_id`);

--
-- Indexes for table `rental_has_equipment_type`
--
ALTER TABLE `rental_has_equipment_type`
  ADD PRIMARY KEY (`rental_id`,`equipment_type_id`),
  ADD KEY `fk_rental_has_equipment_type_equipment_type_idx` (`equipment_type_id`),
  ADD KEY `fk_rental_has_equipment_type_rental_idx` (`rental_id`);

--
-- Indexes for table `rental_has_insurance`
--
ALTER TABLE `rental_has_insurance`
  ADD PRIMARY KEY (`rental_id`,`insurance_id`),
  ADD KEY `fk_rental_has_insurance_insurance_idx` (`insurance_id`),
  ADD KEY `fk_rental_has_insurance_rental_idx` (`rental_id`);

--
-- Indexes for table `rental_invoice`
--
ALTER TABLE `rental_invoice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_rental_invoice_rental_idx` (`rental_id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_vehicle_vehicle_type` (`vehicle_type_id`),
  ADD KEY `fk_vehicle_current_location` (`current_location_id`);

--
-- Indexes for table `vehicle_has_equiment`
--
ALTER TABLE `vehicle_has_equiment`
  ADD PRIMARY KEY (`equipment_id`,`vehicle_id`),
  ADD KEY `fk_equipment_has_vehicle_vehicle_idx` (`vehicle_id`),
  ADD KEY `fk_equipment_has_vehicle_equipment_idx` (`equipment_id`);

--
-- Indexes for table `vehicle_type`
--
ALTER TABLE `vehicle_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rental_invoice`
--
ALTER TABLE `rental_invoice`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `customer`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `equipment`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `equipment_type`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `fuel_option`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `insurance`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `location`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

ALTER TABLE `rental`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `vehicle`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `vehicle_type`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `fk_equipment_equipment_type` FOREIGN KEY (`equipment_type_id`) REFERENCES `equipment_type` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_equipment_location` FOREIGN KEY (`current_location_id`) REFERENCES `location` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `rental`
--
ALTER TABLE `rental`
  ADD CONSTRAINT `fk_rental_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rental_dropoff_location` FOREIGN KEY (`drop_off_location_id`) REFERENCES `location` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rental_fuel_option` FOREIGN KEY (`fuel_option_id`) REFERENCES `fuel_option` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rental_pickup_location` FOREIGN KEY (`pickup_location_id`) REFERENCES `location` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rental_vehicle_type` FOREIGN KEY (`vehicle_type_id`) REFERENCES `vehicle_type` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `rental_has_equipment_type`
--
ALTER TABLE `rental_has_equipment_type`
  ADD CONSTRAINT `fk_rental_has_equipment_type_equipment_type` FOREIGN KEY (`equipment_type_id`) REFERENCES `equipment_type` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rental_has_equipment_type_rental` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `rental_has_insurance`
--
ALTER TABLE `rental_has_insurance`
  ADD CONSTRAINT `fk_rental_has_insurance_insurance` FOREIGN KEY (`insurance_id`) REFERENCES `insurance` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rental_has_insurance_rental` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `rental_invoice`
--
ALTER TABLE `rental_invoice`
  ADD CONSTRAINT `fk_rental_invoice_rental` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD CONSTRAINT `fk_vehicle_current_location` FOREIGN KEY (`current_location_id`) REFERENCES `location` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vehicle_vehicle_type` FOREIGN KEY (`vehicle_type_id`) REFERENCES `vehicle_type` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `vehicle_has_equiment`
--
ALTER TABLE `vehicle_has_equiment`
  ADD CONSTRAINT `fk_equipment_has_vehicle_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_equipment_has_vehicle_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
