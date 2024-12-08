LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY crc32_checker IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        payload : IN STD_LOGIC_VECTOR(45 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_in_valid : IN STD_LOGIC;
        enable_crc : IN STD_LOGIC;
        crc_match : OUT STD_LOGIC;
        crc_complete : OUT STD_LOGIC
    );
END ENTITY crc32_checker;

ARCHITECTURE Behavorial OF crc32_checker IS
    TYPE STATE_TYPE IS (IDLE, GET_CRC, CHECK_CRC, VALIDATE_CRC);

    SIGNAL current_state : STATE_TYPE := IDLE;

    COMPONENT crc IS
        PORT (
            crcIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            data : IN STD_LOGIC_VECTOR(45 DOWNTO 0);
            crcOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL crc_value : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"FFFFFFFF";
    SIGNAL initial_crc : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"FFFFFFFF";

    SIGNAL byte_count : INTEGER RANGE 0 TO 3 := 0;
    SIGNAL input_crc : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"FFFFFFFF";
BEGIN
    crc_inst : crc
    PORT MAP(
        crcIn => initial_crc,
        data => payload,
        crcOut => crc_value
    );

    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            current_state <= IDLE;
            crc_match <= '0';
            crc_complete <= '0';
        ELSIF rising_edge(clk) THEN
            CASE current_state IS
                WHEN IDLE =>
                    IF data_in_valid = '1' AND enable_crc = '1' THEN
                        input_crc(31 DOWNTO 24) <= data_in;
                        byte_count <= 1;
                        current_state <= GET_CRC;
                    END IF;

                WHEN GET_CRC =>
                    IF data_in_valid = '1' THEN
                        IF byte_count = 1 THEN
                            input_crc(23 DOWNTO 16) <= data_in;
                            byte_count <= 2;
                        ELSIF byte_count = 2 THEN
                            input_crc(15 DOWNTO 8) <= data_in;
                            byte_count <= 3;
                        ELSIF byte_count = 3 THEN
                            input_crc(7 DOWNTO 0) <= data_in;
                            byte_count <= 0;
                            current_state <= CHECK_CRC;
                        END IF;
                    END IF;

                WHEN CHECK_CRC =>
                    IF input_crc = crc_value THEN
                        current_state <= VALIDATE_CRC;
                    ELSE
                        crc_complete <= '1';
                        current_state <= IDLE;
                    END IF;

                WHEN VALIDATE_CRC =>
                    crc_match <= '1';
                    crc_complete <= '1';
                    current_state <= IDLE;
            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE Behavorial;