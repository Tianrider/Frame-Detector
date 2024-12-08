LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mac_address_checker IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_in_valid : IN STD_LOGIC;
        enable_mac : IN STD_LOGIC;
        -- own_mac_addr : IN STD_LOGIC_VECTOR(47 DOWNTO 0);

        -- Mode: 0 = Destination MAC, 1 = Source MAC
        mac_mode : IN STD_LOGIC;

        -- Hasil validasi MAC
        mac_valid : OUT STD_LOGIC;

        -- Indikasi selesai membaca MAC
        mac_read_complete : OUT STD_LOGIC
    );
END ENTITY mac_address_checker;

ARCHITECTURE Behavioral OF mac_address_checker IS
    -- Variabel untuk menyimpan MAC yang sedang dibaca
    SIGNAL current_mac : STD_LOGIC_VECTOR(47 DOWNTO 0) := (OTHERS => '0');
    SIGNAL mac_byte_count : INTEGER RANGE 0 TO 5 := 0;
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            current_mac <= (OTHERS => '0');
            mac_byte_count <= 0;
            mac_valid <= '0';
            mac_read_complete <= '0';
        ELSIF rising_edge(clk) THEN
            -- Tambahkan kondisi enable_mac
            IF data_in_valid = '1' AND enable_mac = '1' THEN
                -- Geser MAC dan masukkan byte baru
                current_mac <= current_mac(39 DOWNTO 0) & data_in;

                -- Setelah 6 byte (MAC lengkap)
                IF mac_byte_count = 4 THEN
                    mac_read_complete <= '1';
                    mac_valid <= '1';
                ELSE
                    mac_byte_count <= mac_byte_count + 1;
                    mac_read_complete <= '0';
                END IF;
            ELSIF reset = '1' THEN
                -- Reset kondisi jika disable atau reset
                current_mac <= (OTHERS => '0');
                mac_byte_count <= 0;
                mac_valid <= '0';
                mac_read_complete <= '0';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;