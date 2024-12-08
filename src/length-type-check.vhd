LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY length_type_checker IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_in_valid : IN STD_LOGIC;
        enable_length : IN STD_LOGIC;

        length_type_value : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        length_type_valid : OUT STD_LOGIC;
        length_type_complete : OUT STD_LOGIC
    );
END ENTITY length_type_checker;

ARCHITECTURE Behavioral OF length_type_checker IS
    SIGNAL current_length_type : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL byte_count : INTEGER RANGE 0 TO 1 := 0;
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            current_length_type <= (OTHERS => '0');
            byte_count <= 0;
            length_type_value <= (OTHERS => '0');
            length_type_valid <= '0';
            length_type_complete <= '0';
        ELSIF rising_edge(clk) THEN
            IF data_in_valid = '1' AND enable_length = '1' THEN
                -- Geser dan masukkan byte baru (MSB dulu)
                IF byte_count = 0 THEN
                    current_length_type(15 DOWNTO 8) <= data_in;
                    byte_count <= 1;
                    length_type_complete <= '0';
                ELSIF byte_count = 1 THEN
                    current_length_type(7 DOWNTO 0) <= data_in;
                    byte_count <= 0;
                    length_type_complete <= '1';

                    -- Validasi panjang/tipe frame
                    -- Untuk Ethernet II: nilai > 1500 menandakan tipe protokol
                    -- Untuk IEEE 802.3: nilai <= 1500 menandakan panjang payload
                    IF unsigned(current_length_type(15 DOWNTO 0) & data_in) > x"05DC" THEN
                        length_type_valid <= '0';
                    ELSE
                        length_type_valid <= '1';
                    END IF;

                    -- Keluarkan nilai length/type
                    length_type_value <= current_length_type(15 DOWNTO 8) & data_in;
                END IF;
            ELSIF enable_length = '0' THEN
                -- Reset saat disable
                byte_count <= 0;
                length_type_complete <= '0';
                length_type_valid <= '0';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;