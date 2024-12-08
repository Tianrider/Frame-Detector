-- preamble 32 - BIT :
-- 10101010 10101010 10101010 10101010

-- SFD 8 - BIT :
-- 10101011

-- Destination MAC 48 - BIT :
-- 00010001 00100010 00110011 01000100 01010101 01100110

-- Source MAC 48 - BIT :
-- 10001000 10011001 10101010 10111011 11001100 11011101

-- Length/TYPE 16 - BIT :
-- 00000000 00101110

-- payload 46 - BIT :
-- 00101010 10101100 11110000 11110001 11001010 01001100

-- CRC - 32 :
-- 5F37DA02
-- 01011111 00110111 11011010 00000010

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb IS
END ENTITY tb;

ARCHITECTURE Behavorial OF tb IS
    -- array of inputs
    TYPE preamble_input IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE mac_input IS ARRAY (0 TO 5) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE length_input IS ARRAY (0 TO 1) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE payload_input IS ARRAY (0 TO 5) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE crc_input IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL preamble_input_arr : preamble_input := (
        "10101010", "10101010", "10101010", "10101010", "10101010", "10101010", "10101010", "10101011"
    );

    SIGNAL dest_mac_input_arr : mac_input := (
        "00010001", "00100010", "00110011", "01000100", "01010101", "01100110"
    );

    SIGNAL src_mac_input_arr : mac_input := (
        "10001000", "10011001", "10101010", "10111011", "11001100", "11011101"
    );

    SIGNAL length_input_arr : length_input := (
        "00000000", "00101110"
    );

    SIGNAL payload_input_arr : payload_input := (
        "00101010", "10101100", "11110000", "11110001", "11001010", "01001100"
    );

    SIGNAL crc_input_arr : crc_input := (
        x"80", x"DA", x"EF", x"60"
    );

    COMPONENT EthernetFrameValidator IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            data_in_valid : IN STD_LOGIC;
            frame_valid : OUT STD_LOGIC
        );
    END COMPONENT EthernetFrameValidator;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL data_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_in_valid : STD_LOGIC := '0';
    SIGNAL frame_valid : STD_LOGIC := '0';

    SIGNAL sim_done : BOOLEAN := false;

BEGIN
    uut : EthernetFrameValidator
    PORT MAP(
        clk => clk,
        reset => reset,
        data_in => data_in,
        data_in_valid => data_in_valid,
        frame_valid => frame_valid
    );

    clk_process : PROCESS
    BEGIN
        WHILE NOT sim_done LOOP
            clk <= '0';
            WAIT FOR 5 ns;
            clk <= '1';
            WAIT FOR 5 ns;
        END LOOP;
        WAIT; -- Wait forever after simulation done
    END PROCESS clk_process;

    reset_process : PROCESS
    BEGIN
        reset <= '1';
        WAIT FOR 10 ns;
        reset <= '0';
        WAIT;
    END PROCESS reset_process;

    data_in_process : PROCESS
    BEGIN
        WAIT FOR 20 ns;
        data_in_valid <= '1';

        FOR i IN 0 TO 7 LOOP
            data_in <= preamble_input_arr(i);
            WAIT FOR 10 ns;
        END LOOP;

        WAIT FOR 10 ns;

        FOR i IN 0 TO 5 LOOP
            data_in <= dest_mac_input_arr(i);
            WAIT FOR 10 ns;
        END LOOP;

        FOR i IN 0 TO 5 LOOP
            data_in <= src_mac_input_arr(i);
            WAIT FOR 10 ns;
        END LOOP;

        FOR i IN 0 TO 1 LOOP
            data_in <= length_input_arr(i);
            WAIT FOR 10 ns;
        END LOOP;

        FOR i IN 0 TO 5 LOOP
            data_in <= payload_input_arr(i);
            WAIT FOR 10 ns;
        END LOOP;

        WAIT FOR 20 ns;

        FOR i IN 0 TO 3 LOOP
            data_in <= crc_input_arr(i);
            WAIT FOR 10 ns;
        END LOOP;

        WAIT FOR 30 ns;

        sim_done <= true;
        WAIT;
    END PROCESS data_in_process;
END ARCHITECTURE Behavorial;