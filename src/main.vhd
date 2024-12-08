LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY EthernetFrameValidator IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_in_valid : IN STD_LOGIC;
        frame_valid : OUT STD_LOGIC
    );
END ENTITY EthernetFrameValidator;

ARCHITECTURE Behavorial OF EthernetFrameValidator IS
    TYPE STATE_TYPE IS (IDLE, PREAMBLE_CHECKING, GET_DST_MAC, GET_SRC_MAC, GET_LENGTH, GET_PAYLOAD, CHECK_CRC, VALIDATE_FRAME);
    SIGNAL current_state : STATE_TYPE := IDLE;

    -- signal untuk preamble check
    SIGNAL preamble_detected : STD_LOGIC := '0';
    SIGNAL sfd_detected : STD_LOGIC := '0';

    -- Sinyal untuk MAC Address Checker
    SIGNAL dest_mac_valid : STD_LOGIC := '0';
    SIGNAL src_mac_valid : STD_LOGIC := '0';
    SIGNAL dest_mac_read_complete : STD_LOGIC := '0';
    SIGNAL src_mac_read_complete : STD_LOGIC := '0';

    -- Sinyal untuk Length Type Checker
    SIGNAL length_type_value : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL length_type_valid : STD_LOGIC := '0';
    SIGNAL length_type_complete : STD_LOGIC := '0';

    -- Sinyal untuk Payload Checker
    SIGNAL payload_complete : STD_LOGIC := '0';
    SIGNAL payload_valid : STD_LOGIC := '0';
    SIGNAL payload : STD_LOGIC_VECTOR(45 DOWNTO 0) := (OTHERS => '0');

    -- Sinyal untuk CRC Checker
    SIGNAL crc_match : STD_LOGIC := '0';
    SIGNAL crc_complete : STD_LOGIC := '0';
    SIGNAL crc_value : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

    -- Sinyal enable untuk setiap komponen
    SIGNAL enable_dest_mac : STD_LOGIC := '0';
    SIGNAL enable_src_mac : STD_LOGIC := '0';
    SIGNAL enable_length : STD_LOGIC := '0';
    SIGNAL enable_payload : STD_LOGIC := '0';
    SIGNAL enable_crc : STD_LOGIC := '0';

    COMPONENT preamble_check IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            data_in_valid : IN STD_LOGIC;
            preamble_detected : OUT STD_LOGIC;
            sfd_detected : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT mac_address_checker
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            data_in_valid : IN STD_LOGIC;
            enable_mac : IN STD_LOGIC;
            -- own_mac_addr : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
            mac_mode : IN STD_LOGIC;
            mac_valid : OUT STD_LOGIC;
            mac_read_complete : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT length_type_checker
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
    END COMPONENT;

    COMPONENT payload_checker
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
    END COMPONENT;

    COMPONENT crc32_checker IS
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
    END COMPONENT crc32_checker;

BEGIN
    preamble_check_inst : preamble_check
    PORT MAP(
        clk => clk,
        reset => reset,
        data_in => data_in,
        data_in_valid => data_in_valid,
        preamble_detected => preamble_detected,
        sfd_detected => sfd_detected
    );

    dest_mac_inst : mac_address_checker
    PORT MAP(
        clk => clk,
        reset => reset,
        data_in => data_in,
        data_in_valid => data_in_valid,
        enable_mac => enable_dest_mac,
        -- own_mac_addr => own_mac_addr,
        mac_mode => '0', -- Destination MAC
        mac_valid => dest_mac_valid,
        mac_read_complete => dest_mac_read_complete
    );

    -- Instantiasi Source MAC Checker dengan enable
    src_mac_inst : mac_address_checker
    PORT MAP(
        clk => clk,
        reset => reset,
        data_in => data_in,
        data_in_valid => data_in_valid,
        enable_mac => enable_src_mac,
        -- own_mac_addr => own_mac_addr,
        mac_mode => '1', -- Source MAC
        mac_valid => src_mac_valid,
        mac_read_complete => src_mac_read_complete
    );

    length_type_inst : length_type_checker
    PORT MAP(
        clk => clk,
        reset => reset,
        data_in => data_in,
        data_in_valid => data_in_valid,
        enable_length => enable_length,
        length_type_value => length_type_value,
        length_type_valid => length_type_valid,
        length_type_complete => length_type_complete
    );

    payload_inst : payload_checker
    PORT MAP(
        clk => clk,
        reset => reset,
        data_in => data_in,
        data_in_valid => data_in_valid,
        enable_payload => enable_payload,
        length_type_value => length_type_value,
        payload => payload,
        payload_complete => payload_complete,
        payload_valid => payload_valid
    );

    crc32_inst : crc32_checker
    PORT MAP(
        clk => clk,
        reset => reset,
        payload => payload,
        data_in => data_in,
        data_in_valid => data_in_valid,
        enable_crc => enable_crc,
        crc_match => crc_match,
        crc_complete => crc_complete
    );

    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            frame_valid <= '0';
            current_state <= IDLE;
        ELSIF rising_edge(clk) THEN
            IF data_in_valid = '1' THEN
                CASE current_state IS
                    WHEN IDLE =>
                        frame_valid <= '0';
                        current_state <= PREAMBLE_CHECKING;

                    WHEN PREAMBLE_CHECKING =>
                        IF sfd_detected = '1' THEN
                            current_state <= GET_DST_MAC;
                            enable_dest_mac <= '1';
                        END IF;

                    WHEN GET_DST_MAC =>
                        IF dest_mac_read_complete = '1' THEN
                            enable_dest_mac <= '0';
                            IF dest_mac_valid = '1' THEN
                                current_state <= GET_SRC_MAC;
                                enable_src_mac <= '1';
                            ELSE
                                current_state <= IDLE; -- MAC tidak valid
                            END IF;
                        END IF;

                    WHEN GET_SRC_MAC =>
                        IF src_mac_read_complete = '1' THEN
                            enable_src_mac <= '0'; -- Matikan enable
                            IF src_mac_valid = '1' THEN
                                current_state <= GET_LENGTH;
                                enable_length <= '1';
                            ELSE
                                current_state <= IDLE; -- MAC tidak valid
                            END IF;
                        END IF;

                    WHEN GET_LENGTH =>
                        IF length_type_complete = '1' THEN
                            enable_length <= '0';
                            IF length_type_valid = '1' THEN
                                current_state <= GET_PAYLOAD;
                                enable_payload <= '1';
                            ELSE
                                current_state <= IDLE;
                            END IF;
                        END IF;

                    WHEN GET_PAYLOAD =>
                        IF payload_complete = '1' THEN
                            enable_payload <= '0';
                            IF payload_valid = '1' THEN
                                current_state <= CHECK_CRC;
                                enable_crc <= '1';
                            ELSE
                                current_state <= IDLE;
                            END IF;
                        END IF;

                    WHEN CHECK_CRC =>
                        IF crc_complete = '1' THEN
                            enable_crc <= '0';
                            IF crc_match = '1' THEN
                                current_state <= VALIDATE_FRAME;
                            ELSE
                                current_state <= IDLE;
                            END IF;
                        END IF;

                    WHEN VALIDATE_FRAME =>
                        frame_valid <= '1';
                        current_state <= IDLE;
                END CASE;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;