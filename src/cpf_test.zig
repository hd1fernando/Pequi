const std = @import("std");
const expect = std.testing.expect;
const cpf = @import("cpf.zig");

test "cpf 80123439086 should be valid" {
    const is_valid = cpf.is_valid("80123439086");
    try expect(is_valid == true);
}

test "cpf with non digit should be invalid" {
    const is_valid = cpf.is_valid("a");
    try expect(is_valid == false);
}

test "cpf with dot or trace should be valid" {
    const is_valid = cpf.is_valid("833.668.880-32");
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
