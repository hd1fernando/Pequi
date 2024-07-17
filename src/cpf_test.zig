const std = @import("std");
const expect = std.testing.expect;
const cpf = @import("cpf.zig");

test "cpf 30877598134 should be valid" {
    const is_valid = cpf.is_valid("30877598134");
    try expect(is_valid == true);
}

test "cpf with non digit should be invalid" {
    const is_valid = cpf.is_valid("961.260.812-18");
    try expect(is_valid == false);
}

test "cpf with dot or trace should be valid" {
    const is_valid = cpf.is_valid("801.234.390-86");
    try expect(is_valid == true);
}

test "cpf with less than 11 digits should be invalid" {
    const is_valid = cpf.is_valid("8012343908");
    try expect(is_valid == false);
}

test "cpf with more than 11 digits should be invalid" {
    const is_valid = cpf.is_valid("801234390811");
    try expect(is_valid == false);
}

test "cpf with only same digits should be invalid" {
    const is_valid = cpf.is_valid("111.111.111-11");
    try expect(is_valid == false);
}

test "cpf should be invalid  when first digit is invalid" {
    const is_valid = cpf.is_valid("149.764.610-00");
    try expect(is_valid == false);
}
