-- vim: ts=4 sw=4 expandtab

-- THIS IS GENERATED VHDL CODE.
-- https://bues.ch/h/crcgen
-- 
-- This code is Public Domain.
-- Permission to use, copy, modify, and/or distribute this software for any
-- purpose with or without fee is hereby granted.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
-- WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
-- SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
-- RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
-- NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
-- USE OR PERFORMANCE OF THIS SOFTWARE.

-- CRC polynomial coefficients: x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
--                              0xEDB88320 (hex)
-- CRC width:                   32 bits
-- CRC shift direction:         right (little endian)
-- Input word width:            46 bits

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY crc IS
    PORT (
        crcIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        data : IN STD_LOGIC_VECTOR(45 DOWNTO 0);
        crcOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY crc;

ARCHITECTURE Behavioral OF crc IS
BEGIN
    crcOut(0) <= crcIn(1) XOR crcIn(2) XOR crcIn(9) XOR crcIn(12) XOR crcIn(14) XOR crcIn(15) XOR crcIn(16) XOR crcIn(17) XOR crcIn(18) XOR crcIn(20) XOR crcIn(21) XOR crcIn(22) XOR crcIn(30) XOR data(1) XOR data(2) XOR data(9) XOR data(12) XOR data(14) XOR data(15) XOR data(16) XOR data(17) XOR data(18) XOR data(20) XOR data(21) XOR data(22) XOR data(30) XOR data(34) XOR data(36) XOR data(37) XOR data(40);
    crcOut(1) <= crcIn(0) XOR crcIn(2) XOR crcIn(3) XOR crcIn(10) XOR crcIn(13) XOR crcIn(15) XOR crcIn(16) XOR crcIn(17) XOR crcIn(18) XOR crcIn(19) XOR crcIn(21) XOR crcIn(22) XOR crcIn(23) XOR crcIn(31) XOR data(0) XOR data(2) XOR data(3) XOR data(10) XOR data(13) XOR data(15) XOR data(16) XOR data(17) XOR data(18) XOR data(19) XOR data(21) XOR data(22) XOR data(23) XOR data(31) XOR data(35) XOR data(37) XOR data(38) XOR data(41);
    crcOut(2) <= crcIn(0) XOR crcIn(1) XOR crcIn(3) XOR crcIn(4) XOR crcIn(11) XOR crcIn(14) XOR crcIn(16) XOR crcIn(17) XOR crcIn(18) XOR crcIn(19) XOR crcIn(20) XOR crcIn(22) XOR crcIn(23) XOR crcIn(24) XOR data(0) XOR data(1) XOR data(3) XOR data(4) XOR data(11) XOR data(14) XOR data(16) XOR data(17) XOR data(18) XOR data(19) XOR data(20) XOR data(22) XOR data(23) XOR data(24) XOR data(32) XOR data(36) XOR data(38) XOR data(39) XOR data(42);
    crcOut(3) <= crcIn(1) XOR crcIn(2) XOR crcIn(4) XOR crcIn(5) XOR crcIn(12) XOR crcIn(15) XOR crcIn(17) XOR crcIn(18) XOR crcIn(19) XOR crcIn(20) XOR crcIn(21) XOR crcIn(23) XOR crcIn(24) XOR crcIn(25) XOR data(1) XOR data(2) XOR data(4) XOR data(5) XOR data(12) XOR data(15) XOR data(17) XOR data(18) XOR data(19) XOR data(20) XOR data(21) XOR data(23) XOR data(24) XOR data(25) XOR data(33) XOR data(37) XOR data(39) XOR data(40) XOR data(43);
    crcOut(4) <= crcIn(0) XOR crcIn(2) XOR crcIn(3) XOR crcIn(5) XOR crcIn(6) XOR crcIn(13) XOR crcIn(16) XOR crcIn(18) XOR crcIn(19) XOR crcIn(20) XOR crcIn(21) XOR crcIn(22) XOR crcIn(24) XOR crcIn(25) XOR crcIn(26) XOR data(0) XOR data(2) XOR data(3) XOR data(5) XOR data(6) XOR data(13) XOR data(16) XOR data(18) XOR data(19) XOR data(20) XOR data(21) XOR data(22) XOR data(24) XOR data(25) XOR data(26) XOR data(34) XOR data(38) XOR data(40) XOR data(41) XOR data(44);
    crcOut(5) <= crcIn(1) XOR crcIn(3) XOR crcIn(4) XOR crcIn(6) XOR crcIn(7) XOR crcIn(14) XOR crcIn(17) XOR crcIn(19) XOR crcIn(20) XOR crcIn(21) XOR crcIn(22) XOR crcIn(23) XOR crcIn(25) XOR crcIn(26) XOR crcIn(27) XOR data(1) XOR data(3) XOR data(4) XOR data(6) XOR data(7) XOR data(14) XOR data(17) XOR data(19) XOR data(20) XOR data(21) XOR data(22) XOR data(23) XOR data(25) XOR data(26) XOR data(27) XOR data(35) XOR data(39) XOR data(41) XOR data(42) XOR data(45);
    crcOut(6) <= crcIn(1) XOR crcIn(4) XOR crcIn(5) XOR crcIn(7) XOR crcIn(8) XOR crcIn(9) XOR crcIn(12) XOR crcIn(14) XOR crcIn(16) XOR crcIn(17) XOR crcIn(23) XOR crcIn(24) XOR crcIn(26) XOR crcIn(27) XOR crcIn(28) XOR crcIn(30) XOR data(1) XOR data(4) XOR data(5) XOR data(7) XOR data(8) XOR data(9) XOR data(12) XOR data(14) XOR data(16) XOR data(17) XOR data(23) XOR data(24) XOR data(26) XOR data(27) XOR data(28) XOR data(30) XOR data(34) XOR data(37) XOR data(42) XOR data(43);
    crcOut(7) <= crcIn(2) XOR crcIn(5) XOR crcIn(6) XOR crcIn(8) XOR crcIn(9) XOR crcIn(10) XOR crcIn(13) XOR crcIn(15) XOR crcIn(17) XOR crcIn(18) XOR crcIn(24) XOR crcIn(25) XOR crcIn(27) XOR crcIn(28) XOR crcIn(29) XOR crcIn(31) XOR data(2) XOR data(5) XOR data(6) XOR data(8) XOR data(9) XOR data(10) XOR data(13) XOR data(15) XOR data(17) XOR data(18) XOR data(24) XOR data(25) XOR data(27) XOR data(28) XOR data(29) XOR data(31) XOR data(35) XOR data(38) XOR data(43) XOR data(44);
    crcOut(8) <= crcIn(3) XOR crcIn(6) XOR crcIn(7) XOR crcIn(9) XOR crcIn(10) XOR crcIn(11) XOR crcIn(14) XOR crcIn(16) XOR crcIn(18) XOR crcIn(19) XOR crcIn(25) XOR crcIn(26) XOR crcIn(28) XOR crcIn(29) XOR crcIn(30) XOR data(3) XOR data(6) XOR data(7) XOR data(9) XOR data(10) XOR data(11) XOR data(14) XOR data(16) XOR data(18) XOR data(19) XOR data(25) XOR data(26) XOR data(28) XOR data(29) XOR data(30) XOR data(32) XOR data(36) XOR data(39) XOR data(44) XOR data(45);
    crcOut(9) <= crcIn(0) XOR crcIn(1) XOR crcIn(2) XOR crcIn(4) XOR crcIn(7) XOR crcIn(8) XOR crcIn(9) XOR crcIn(10) XOR crcIn(11) XOR crcIn(14) XOR crcIn(16) XOR crcIn(18) XOR crcIn(19) XOR crcIn(21) XOR crcIn(22) XOR crcIn(26) XOR crcIn(27) XOR crcIn(29) XOR crcIn(31) XOR data(0) XOR data(1) XOR data(2) XOR data(4) XOR data(7) XOR data(8) XOR data(9) XOR data(10) XOR data(11) XOR data(14) XOR data(16) XOR data(18) XOR data(19) XOR data(21) XOR data(22) XOR data(26) XOR data(27) XOR data(29) XOR data(31) XOR data(33) XOR data(34) XOR data(36) XOR data(45);
    crcOut(10) <= crcIn(3) XOR crcIn(5) XOR crcIn(8) XOR crcIn(10) XOR crcIn(11) XOR crcIn(14) XOR crcIn(16) XOR crcIn(18) XOR crcIn(19) XOR crcIn(21) XOR crcIn(23) XOR crcIn(27) XOR crcIn(28) XOR data(3) XOR data(5) XOR data(8) XOR data(10) XOR data(11) XOR data(14) XOR data(16) XOR data(18) XOR data(19) XOR data(21) XOR data(23) XOR data(27) XOR data(28) XOR data(32) XOR data(35) XOR data(36) XOR data(40);
    crcOut(11) <= crcIn(4) XOR crcIn(6) XOR crcIn(9) XOR crcIn(11) XOR crcIn(12) XOR crcIn(15) XOR crcIn(17) XOR crcIn(19) XOR crcIn(20) XOR crcIn(22) XOR crcIn(24) XOR crcIn(28) XOR crcIn(29) XOR data(4) XOR data(6) XOR data(9) XOR data(11) XOR data(12) XOR data(15) XOR data(17) XOR data(19) XOR data(20) XOR data(22) XOR data(24) XOR data(28) XOR data(29) XOR data(33) XOR data(36) XOR data(37) XOR data(41);
    crcOut(12) <= crcIn(5) XOR crcIn(7) XOR crcIn(10) XOR crcIn(12) XOR crcIn(13) XOR crcIn(16) XOR crcIn(18) XOR crcIn(20) XOR crcIn(21) XOR crcIn(23) XOR crcIn(25) XOR crcIn(29) XOR crcIn(30) XOR data(5) XOR data(7) XOR data(10) XOR data(12) XOR data(13) XOR data(16) XOR data(18) XOR data(20) XOR data(21) XOR data(23) XOR data(25) XOR data(29) XOR data(30) XOR data(34) XOR data(37) XOR data(38) XOR data(42);
    crcOut(13) <= crcIn(6) XOR crcIn(8) XOR crcIn(11) XOR crcIn(13) XOR crcIn(14) XOR crcIn(17) XOR crcIn(19) XOR crcIn(21) XOR crcIn(22) XOR crcIn(24) XOR crcIn(26) XOR crcIn(30) XOR crcIn(31) XOR data(6) XOR data(8) XOR data(11) XOR data(13) XOR data(14) XOR data(17) XOR data(19) XOR data(21) XOR data(22) XOR data(24) XOR data(26) XOR data(30) XOR data(31) XOR data(35) XOR data(38) XOR data(39) XOR data(43);
    crcOut(14) <= crcIn(0) XOR crcIn(7) XOR crcIn(9) XOR crcIn(12) XOR crcIn(14) XOR crcIn(15) XOR crcIn(18) XOR crcIn(20) XOR crcIn(22) XOR crcIn(23) XOR crcIn(25) XOR crcIn(27) XOR crcIn(31) XOR data(0) XOR data(7) XOR data(9) XOR data(12) XOR data(14) XOR data(15) XOR data(18) XOR data(20) XOR data(22) XOR data(23) XOR data(25) XOR data(27) XOR data(31) XOR data(32) XOR data(36) XOR data(39) XOR data(40) XOR data(44);
    crcOut(15) <= crcIn(1) XOR crcIn(8) XOR crcIn(10) XOR crcIn(13) XOR crcIn(15) XOR crcIn(16) XOR crcIn(19) XOR crcIn(21) XOR crcIn(23) XOR crcIn(24) XOR crcIn(26) XOR crcIn(28) XOR data(1) XOR data(8) XOR data(10) XOR data(13) XOR data(15) XOR data(16) XOR data(19) XOR data(21) XOR data(23) XOR data(24) XOR data(26) XOR data(28) XOR data(32) XOR data(33) XOR data(37) XOR data(40) XOR data(41) XOR data(45);
    crcOut(16) <= crcIn(0) XOR crcIn(1) XOR crcIn(11) XOR crcIn(12) XOR crcIn(15) XOR crcIn(18) XOR crcIn(21) XOR crcIn(24) XOR crcIn(25) XOR crcIn(27) XOR crcIn(29) XOR crcIn(30) XOR data(0) XOR data(1) XOR data(11) XOR data(12) XOR data(15) XOR data(18) XOR data(21) XOR data(24) XOR data(25) XOR data(27) XOR data(29) XOR data(30) XOR data(33) XOR data(36) XOR data(37) XOR data(38) XOR data(40) XOR data(41) XOR data(42);
    crcOut(17) <= crcIn(1) XOR crcIn(2) XOR crcIn(12) XOR crcIn(13) XOR crcIn(16) XOR crcIn(19) XOR crcIn(22) XOR crcIn(25) XOR crcIn(26) XOR crcIn(28) XOR crcIn(30) XOR crcIn(31) XOR data(1) XOR data(2) XOR data(12) XOR data(13) XOR data(16) XOR data(19) XOR data(22) XOR data(25) XOR data(26) XOR data(28) XOR data(30) XOR data(31) XOR data(34) XOR data(37) XOR data(38) XOR data(39) XOR data(41) XOR data(42) XOR data(43);
    crcOut(18) <= crcIn(2) XOR crcIn(3) XOR crcIn(13) XOR crcIn(14) XOR crcIn(17) XOR crcIn(20) XOR crcIn(23) XOR crcIn(26) XOR crcIn(27) XOR crcIn(29) XOR crcIn(31) XOR data(2) XOR data(3) XOR data(13) XOR data(14) XOR data(17) XOR data(20) XOR data(23) XOR data(26) XOR data(27) XOR data(29) XOR data(31) XOR data(32) XOR data(35) XOR data(38) XOR data(39) XOR data(40) XOR data(42) XOR data(43) XOR data(44);
    crcOut(19) <= crcIn(3) XOR crcIn(4) XOR crcIn(14) XOR crcIn(15) XOR crcIn(18) XOR crcIn(21) XOR crcIn(24) XOR crcIn(27) XOR crcIn(28) XOR crcIn(30) XOR data(3) XOR data(4) XOR data(14) XOR data(15) XOR data(18) XOR data(21) XOR data(24) XOR data(27) XOR data(28) XOR data(30) XOR data(32) XOR data(33) XOR data(36) XOR data(39) XOR data(40) XOR data(41) XOR data(43) XOR data(44) XOR data(45);
    crcOut(20) <= crcIn(0) XOR crcIn(1) XOR crcIn(2) XOR crcIn(4) XOR crcIn(5) XOR crcIn(9) XOR crcIn(12) XOR crcIn(14) XOR crcIn(17) XOR crcIn(18) XOR crcIn(19) XOR crcIn(20) XOR crcIn(21) XOR crcIn(25) XOR crcIn(28) XOR crcIn(29) XOR crcIn(30) XOR crcIn(31) XOR data(0) XOR data(1) XOR data(2) XOR data(4) XOR data(5) XOR data(9) XOR data(12) XOR data(14) XOR data(17) XOR data(18) XOR data(19) XOR data(20) XOR data(21) XOR data(25) XOR data(28) XOR data(29) XOR data(30) XOR data(31) XOR data(33) XOR data(36) XOR data(41) XOR data(42) XOR data(44) XOR data(45);
    crcOut(21) <= crcIn(3) XOR crcIn(5) XOR crcIn(6) XOR crcIn(9) XOR crcIn(10) XOR crcIn(12) XOR crcIn(13) XOR crcIn(14) XOR crcIn(16) XOR crcIn(17) XOR crcIn(19) XOR crcIn(26) XOR crcIn(29) XOR crcIn(31) XOR data(3) XOR data(5) XOR data(6) XOR data(9) XOR data(10) XOR data(12) XOR data(13) XOR data(14) XOR data(16) XOR data(17) XOR data(19) XOR data(26) XOR data(29) XOR data(31) XOR data(32) XOR data(36) XOR data(40) XOR data(42) XOR data(43) XOR data(45);
    crcOut(22) <= crcIn(1) XOR crcIn(2) XOR crcIn(4) XOR crcIn(6) XOR crcIn(7) XOR crcIn(9) XOR crcIn(10) XOR crcIn(11) XOR crcIn(12) XOR crcIn(13) XOR crcIn(16) XOR crcIn(21) XOR crcIn(22) XOR crcIn(27) XOR data(1) XOR data(2) XOR data(4) XOR data(6) XOR data(7) XOR data(9) XOR data(10) XOR data(11) XOR data(12) XOR data(13) XOR data(16) XOR data(21) XOR data(22) XOR data(27) XOR data(32) XOR data(33) XOR data(34) XOR data(36) XOR data(40) XOR data(41) XOR data(43) XOR data(44);
    crcOut(23) <= crcIn(0) XOR crcIn(2) XOR crcIn(3) XOR crcIn(5) XOR crcIn(7) XOR crcIn(8) XOR crcIn(10) XOR crcIn(11) XOR crcIn(12) XOR crcIn(13) XOR crcIn(14) XOR crcIn(17) XOR crcIn(22) XOR crcIn(23) XOR crcIn(28) XOR data(0) XOR data(2) XOR data(3) XOR data(5) XOR data(7) XOR data(8) XOR data(10) XOR data(11) XOR data(12) XOR data(13) XOR data(14) XOR data(17) XOR data(22) XOR data(23) XOR data(28) XOR data(33) XOR data(34) XOR data(35) XOR data(37) XOR data(41) XOR data(42) XOR data(44) XOR data(45);
    crcOut(24) <= crcIn(0) XOR crcIn(2) XOR crcIn(3) XOR crcIn(4) XOR crcIn(6) XOR crcIn(8) XOR crcIn(11) XOR crcIn(13) XOR crcIn(16) XOR crcIn(17) XOR crcIn(20) XOR crcIn(21) XOR crcIn(22) XOR crcIn(23) XOR crcIn(24) XOR crcIn(29) XOR crcIn(30) XOR data(0) XOR data(2) XOR data(3) XOR data(4) XOR data(6) XOR data(8) XOR data(11) XOR data(13) XOR data(16) XOR data(17) XOR data(20) XOR data(21) XOR data(22) XOR data(23) XOR data(24) XOR data(29) XOR data(30) XOR data(35) XOR data(37) XOR data(38) XOR data(40) XOR data(42) XOR data(43) XOR data(45);
    crcOut(25) <= crcIn(0) XOR crcIn(2) XOR crcIn(3) XOR crcIn(4) XOR crcIn(5) XOR crcIn(7) XOR crcIn(15) XOR crcIn(16) XOR crcIn(20) XOR crcIn(23) XOR crcIn(24) XOR crcIn(25) XOR crcIn(31) XOR data(0) XOR data(2) XOR data(3) XOR data(4) XOR data(5) XOR data(7) XOR data(15) XOR data(16) XOR data(20) XOR data(23) XOR data(24) XOR data(25) XOR data(31) XOR data(34) XOR data(37) XOR data(38) XOR data(39) XOR data(40) XOR data(41) XOR data(43) XOR data(44);
    crcOut(26) <= crcIn(1) XOR crcIn(3) XOR crcIn(4) XOR crcIn(5) XOR crcIn(6) XOR crcIn(8) XOR crcIn(16) XOR crcIn(17) XOR crcIn(21) XOR crcIn(24) XOR crcIn(25) XOR crcIn(26) XOR data(1) XOR data(3) XOR data(4) XOR data(5) XOR data(6) XOR data(8) XOR data(16) XOR data(17) XOR data(21) XOR data(24) XOR data(25) XOR data(26) XOR data(32) XOR data(35) XOR data(38) XOR data(39) XOR data(40) XOR data(41) XOR data(42) XOR data(44) XOR data(45);
    crcOut(27) <= crcIn(0) XOR crcIn(1) XOR crcIn(4) XOR crcIn(5) XOR crcIn(6) XOR crcIn(7) XOR crcIn(12) XOR crcIn(14) XOR crcIn(15) XOR crcIn(16) XOR crcIn(20) XOR crcIn(21) XOR crcIn(25) XOR crcIn(26) XOR crcIn(27) XOR crcIn(30) XOR data(0) XOR data(1) XOR data(4) XOR data(5) XOR data(6) XOR data(7) XOR data(12) XOR data(14) XOR data(15) XOR data(16) XOR data(20) XOR data(21) XOR data(25) XOR data(26) XOR data(27) XOR data(30) XOR data(33) XOR data(34) XOR data(37) XOR data(39) XOR data(41) XOR data(42) XOR data(43) XOR data(45);
    crcOut(28) <= crcIn(0) XOR crcIn(5) XOR crcIn(6) XOR crcIn(7) XOR crcIn(8) XOR crcIn(9) XOR crcIn(12) XOR crcIn(13) XOR crcIn(14) XOR crcIn(18) XOR crcIn(20) XOR crcIn(26) XOR crcIn(27) XOR crcIn(28) XOR crcIn(30) XOR crcIn(31) XOR data(0) XOR data(5) XOR data(6) XOR data(7) XOR data(8) XOR data(9) XOR data(12) XOR data(13) XOR data(14) XOR data(18) XOR data(20) XOR data(26) XOR data(27) XOR data(28) XOR data(30) XOR data(31) XOR data(35) XOR data(36) XOR data(37) XOR data(38) XOR data(42) XOR data(43) XOR data(44);
    crcOut(29) <= crcIn(1) XOR crcIn(6) XOR crcIn(7) XOR crcIn(8) XOR crcIn(9) XOR crcIn(10) XOR crcIn(13) XOR crcIn(14) XOR crcIn(15) XOR crcIn(19) XOR crcIn(21) XOR crcIn(27) XOR crcIn(28) XOR crcIn(29) XOR crcIn(31) XOR data(1) XOR data(6) XOR data(7) XOR data(8) XOR data(9) XOR data(10) XOR data(13) XOR data(14) XOR data(15) XOR data(19) XOR data(21) XOR data(27) XOR data(28) XOR data(29) XOR data(31) XOR data(32) XOR data(36) XOR data(37) XOR data(38) XOR data(39) XOR data(43) XOR data(44) XOR data(45);
    crcOut(30) <= crcIn(1) XOR crcIn(7) XOR crcIn(8) XOR crcIn(10) XOR crcIn(11) XOR crcIn(12) XOR crcIn(17) XOR crcIn(18) XOR crcIn(21) XOR crcIn(28) XOR crcIn(29) XOR data(1) XOR data(7) XOR data(8) XOR data(10) XOR data(11) XOR data(12) XOR data(17) XOR data(18) XOR data(21) XOR data(28) XOR data(29) XOR data(32) XOR data(33) XOR data(34) XOR data(36) XOR data(38) XOR data(39) XOR data(44) XOR data(45);
    crcOut(31) <= crcIn(0) XOR crcIn(1) XOR crcIn(8) XOR crcIn(11) XOR crcIn(13) XOR crcIn(14) XOR crcIn(15) XOR crcIn(16) XOR crcIn(17) XOR crcIn(19) XOR crcIn(20) XOR crcIn(21) XOR crcIn(29) XOR data(0) XOR data(1) XOR data(8) XOR data(11) XOR data(13) XOR data(14) XOR data(15) XOR data(16) XOR data(17) XOR data(19) XOR data(20) XOR data(21) XOR data(29) XOR data(33) XOR data(35) XOR data(36) XOR data(39) XOR data(45);
END ARCHITECTURE Behavioral;