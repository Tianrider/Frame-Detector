LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY payload_checker IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_in_valid : IN STD_LOGIC;
        enable_payload : IN STD_LOGIC;
        length_type_value : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        payload : OUT STD_LOGIC_VECTOR(45 DOWNTO 0);
        payload_complete : OUT STD_LOGIC;
        payload_valid : OUT STD_LOGIC
    );
END ENTITY payload_checker;

ARCHITECTURE Behavioral OF payload_checker IS
    SIGNAL payload_byte_count : INTEGER RANGE 0 TO 1500 := 0;
    SIGNAL max_payload_length : INTEGER RANGE 0 TO 1500;
    SIGNAL internal_payload : STD_LOGIC_VECTOR(45 DOWNTO 0);
BEGIN
    -- Konversi panjang payload dari length/type
    max_payload_length <= to_integer(unsigned(length_type_value))
        WHEN unsigned(length_type_value) <= x"05DC"
        ELSE
        1500;

    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            payload_byte_count <= 0;
            payload_complete <= '0';
            payload_valid <= '0';
        ELSIF rising_edge(clk) THEN
            IF data_in_valid = '1' AND enable_payload = '1' THEN
                -- Masukkan data ke payload MSB first
                internal_payload <= internal_payload(37 DOWNTO 0) & data_in;

                -- Setelah mencapai panjang maksimum payload
                IF payload_byte_count = 5 THEN
                    payload_complete <= '1';
                    payload_valid <= '1';
                    payload <= internal_payload;
                ELSE
                    payload <= internal_payload;
                    payload_byte_count <= payload_byte_count + 1;
                END IF;
            ELSIF enable_payload = '0' THEN
                -- Reset saat disable
                payload_byte_count <= 0;
                payload_complete <= '0';
                payload_valid <= '0';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;