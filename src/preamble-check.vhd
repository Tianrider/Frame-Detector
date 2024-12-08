LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY preamble_check IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_in_valid : IN STD_LOGIC;
        preamble_detected : OUT STD_LOGIC;
        sfd_detected : OUT STD_LOGIC
    );
END ENTITY preamble_check;

ARCHITECTURE Behavioral OF preamble_check IS
    CONSTANT PREAMBLE_PATTERN : STD_LOGIC_VECTOR(7 DOWNTO 0) := "10101010";
    CONSTANT SFD_PATTERN : STD_LOGIC_VECTOR(7 DOWNTO 0) := "10101011";

    SIGNAL preamble_count : INTEGER RANGE 0 TO 7 := 0;
    TYPE state_type IS (IDLE, PREAMBLE_CHECK, SFD_CHECK);

    SIGNAL current_state : state_type := IDLE;

BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            current_state <= IDLE;
            preamble_count <= 0;
            preamble_detected <= '0';
            sfd_detected <= '0';
        ELSIF rising_edge(clk) THEN
            IF data_in_valid = '1' THEN
                CASE current_state IS
                    WHEN IDLE =>
                        IF data_in = PREAMBLE_PATTERN THEN
                            current_state <= PREAMBLE_CHECK;
                            preamble_count <= 1;
                            preamble_detected <= '1';
                            sfd_detected <= '0';
                        END IF;

                    WHEN PREAMBLE_CHECK =>
                        IF data_in = PREAMBLE_PATTERN THEN
                            IF preamble_count = 6 THEN
                                current_state <= SFD_CHECK;
                            ELSE
                                preamble_count <= preamble_count + 1;
                            END IF;
                        ELSE
                            current_state <= IDLE;
                            preamble_count <= 0;
                        END IF;

                    WHEN SFD_CHECK =>
                        IF data_in = SFD_PATTERN THEN
                            sfd_detected <= '1';
                            current_state <= IDLE;
                        ELSE
                            current_state <= IDLE;
                        END IF;
                        preamble_count <= 0;
                END CASE;
            END IF;
        END IF;
    END PROCESS;
END Behavioral;