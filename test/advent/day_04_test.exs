defmodule Advent.Day04Test do
  use Advent.FileCase

  alias Advent.Day04

  test "Part 1 - example" do
    input = """
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm

    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929

    hcl:#ae17e1 iyr:2013
    eyr:2024
    ecl:brn pid:760753108 byr:1931
    hgt:179cm

    hcl:#cfa07d eyr:2025 pid:166559648
    iyr:2011 ecl:brn hgt:59in
    """

    assert Day04.part_1(input) == 2
  end

  test "Part 1 - input file" do
    input = load_file("day-04")
    assert Day04.part_1(input) == 260
  end

  test "validate_field/1 with byr" do
    assert Day04.validate_field("byr:2002")
    refute Day04.validate_field("byr:2003")
  end

  test "validate_field/1 with hgt" do
    assert Day04.validate_field("hgt:60in")
    assert Day04.validate_field("hgt:190cm")
    refute Day04.validate_field("hgt:190in")
    refute Day04.validate_field("hgt:190")
  end

  test "validate_field/1 with hcl" do
    assert Day04.validate_field("hcl:#123abc")
    refute Day04.validate_field("hcl:#123abz")
    refute Day04.validate_field("hcl:123abc")
  end

  test "validate_field/1 with ecl" do
    assert Day04.validate_field("ecl:brn")
    refute Day04.validate_field("ecl:wat")
  end

  test "validate_field/1 with pid" do
    assert Day04.validate_field("pid:000000001")
    refute Day04.validate_field("pid:0123456789")
  end

  test "Part 2 - returns `0` with invalid passports" do
    input = """
    eyr:1972 cid:100
    hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

    iyr:2019
    hcl:#602927 eyr:1967 hgt:170cm
    ecl:grn pid:012533040 byr:1946

    hcl:dab227 iyr:2012
    ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

    hgt:59cm ecl:zzz
    eyr:2038 hcl:74454a iyr:2023
    pid:3556412378 byr:2007
    """

    assert Day04.part_2(input) == 0
  end

  test "Part 2 - returns `4` with four valid passports" do
    input = """
    pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
    hcl:#623a2f

    eyr:2029 ecl:blu cid:129 byr:1989
    iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

    hcl:#888785
    hgt:164cm byr:2001 iyr:2015 cid:88
    pid:545766238 ecl:hzl
    eyr:2022

    iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
    """

    assert Day04.part_2(input) == 4
  end

  test "Part 2 - input file" do
    input = load_file("day-04")
    assert Day04.part_2(input) == 153
  end
end
