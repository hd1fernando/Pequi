const std = @import("std");
const expect = std.testing.expect;
const cpf = @import("cpf.zig");

test "cpf 30877598134 should be valid" {
    const result = try cpf.is_valid("30877598134");
    try expect(result == result);
}

test "cpf with non digit should be invalid" {
    const result = try cpf.is_valid("961.260.812-1a");
    try expect(result == false);
}

test "cpf with dot or trace should be valid" {
    const result = try cpf.is_valid("801.234.390-86");
    try expect(result == true);
}

test "cpf with less than 11 digits should be invalid" {
    const result = try cpf.is_valid("8012343908") == true;
    try expect(result == false);
}

test "cpf with more than 11 digits should be invalid" {
    const result = try cpf.is_valid("801234390811");
    try expect(result == false);
}

test "cpf with only same digits should be invalid" {
    const result = try cpf.is_valid("111.111.111-11");
    try expect(result == false);
}

test "cpf should be invalid  when first digit is invalid" {
    const result = try cpf.is_valid("149.764.610-00");
    try expect(result == false);
}

test "cpf should be invalid when second digit is invalid" {
    const result = try cpf.is_valid("30877598130");
    try expect(result == false);
}
