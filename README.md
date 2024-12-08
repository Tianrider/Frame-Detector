# Ethernet-Frame-Validator

## Latar Belakang

Proyek Ethernet-Frame-Validator adalah proyek yang bertujuan untuk memvalidasi frame ethernet yang diterima oleh sebuah perangkat jaringan menggunakan algoritma CRC-32. Proyek ini dibuat untuk memenuhi tugas mata kuliah Perancangan Sistem Digital. Proyek ini terdiri dari beberapa file VHDL, termasuk modul untuk memeriksa Cyclic Redundancy Check (CRC), panjang dan tipe frame, alamat MAC, isi payload, dan preamble. Setiap modul berfungsi untuk memastikan bahwa data yang diterima sesuai dengan spesifikasi yang diharapkan dan bebas dari kesalahan.

## Deskripsi Proyek

Sebuah frame Ethernet terdiri dari beberapa bagian, yaitu:

1. Preamble: 7 byte
2. Start of Frame Delimiter (SFD): 1 byte
3. Alamat MAC Penerima: 6 byte
4. Alamat MAC Pengirim: 6 byte
5. Tipe/Panjang Payload: 2 byte
6. Payload: 46-1500 byte
7. CRC: 4 byte

Semua bagian frame tersebut harus diperiksa agar tidak terjadi kesalahan dalam pengiriman data.

**Keterbatasan Proyek:**

> Input payload terbatas ke 46-bit saja (ini berarti panjang payload tidak berpengaruh pada payload yang akan dibaca)

#### Preamble

Preamble adalah bagian dari frame Ethernet yang terdiri dari 7 byte yang berisi pola bit 10101010. Preamble digunakan untuk memberikan waktu bagi perangkat jaringan untuk melakukan sinkronisasi bit. Pada proyek ini, preamble akan diperiksa apakah terdiri dari pola bit 10101010 atau tidak.

```vhdl
CONSTANT PREAMBLE_PATTERN : STD_LOGIC_VECTOR(7 DOWNTO 0) := "10101010";
CONSTANT SFD_PATTERN : STD_LOGIC_VECTOR(7 DOWNTO 0) := "10101011";

IF data_in = PREAMBLE_PATTERN THEN
  current_state <= PREAMBLE_CHECK;
  preamble_count <= 1;
  preamble_detected <= '1';
  sfd_detected <= '0';
END IF;
```

#### Start of Frame Delimiter (SFD)

SFD adalah bagian dari frame Ethernet yang terdiri dari 1 byte yang berisi pola bit 10101011. SFD digunakan untuk menandai akhir dari preamble dan awal dari alamat MAC penerima.

```vhdl
IF data_in = SFD_PATTERN THEN
  current_state <= SFD_CHECK;
  sfd_detected <= '1';
END IF;
```

#### Alamat MAC

Alamat MAC adalah bagian dari frame Ethernet yang terdiri dari 6 byte yang berisi alamat MAC penerima dan pengirim.

```vhdl
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
```

#### Tipe/Panjang Payload

Tipe/Panjang Payload adalah bagian dari frame Ethernet yang terdiri dari 2 byte yang berisi tipe atau panjang payload yang akan diterima.

```vhdl
IF byte_count = 0 THEN
    current_length_type(15 DOWNTO 8) <= data_in;
    byte_count <= 1;
    length_type_complete <= '0';
ELSIF byte_count = 1 THEN
    current_length_type(7 DOWNTO 0) <= data_in;
    byte_count <= 0;
    length_type_complete <= '1';
```

#### Payload

Payload adalah data yang akan dikirimkan melalui frame Ethernet. Payload memiliki panjang minimal 46 byte dan maksimal 1500 byte. Pada proyek ini, panjang payload bernilai fixed di 46 bit.

```vhdl
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
```

#### CRC

CRC adalah bagian dari frame Ethernet yang terdiri dari 4 byte yang berisi hasil CRC-32 dari frame Ethernet yang dikirimkan. CRC digunakan untuk memastikan bahwa data yang diterima tidak mengalami kesalahan. Algoritma CRC yang diguanakan di proyek ini secara eksplisit terpisah dan berada di file `crc.vhd`. Algoritma ini adalah algoritma khusus untuk frame ethernet dengan panjang payload 46 bit.

```vhdl
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
```

#### Finite State Machine

![picture 0](https://i.imgur.com/L9VJmyc.png)

#### Wave Result

![picture 1](https://i.imgur.com/eEcxbWy.png)

### Contributors

-   Christian Hadiwijaya 2306161952
-   Fido Wahyu Choirulinsan 2306250674
-   Muhammad Hilmy Mahardika 2306267006
-   Raddief Ezra Satrio Andaru 2306250693
