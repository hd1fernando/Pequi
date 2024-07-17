const std = @import("std");

pub fn is_valid(cpf: []const u8) bool {
    if (is_only_digits(cpf) == false)
        return false;
    if (has_valid_size(cpf) == false)
        return false;

    const new_cpf = remove_mask(cpf);
    if (has_only_same_digits(new_cpf))
        return false;

    return true;
}

fn has_only_same_digits(cpf: []const u8) bool {
    var buff: u8 = cpf[0];
    for (cpf) |elem| {
        if (elem != buff)
            return false;
        buff = elem;
    }
    return true;
}

fn remove_mask(cpf: []const u8) []const u8 {
    var new_cpf: [11]u8 = undefined;
    var counter: usize = 0;
    for (cpf) |elem| {
        if (is_digit(elem)) {
            new_cpf[counter] = elem;
            counter += 1;
        }
    }
    return &new_cpf;
}

fn is_only_digits(cpf: []const u8) bool {
    for (cpf) |elem| {
        if (elem == 0x2d)
            continue;
        if (elem == 0x2e)
            continue;
        if (is_digit(elem) == false)
            return false;
    }
    return true;
}

fn is_digit(char: u8) bool {
    if (char < 0x30)
        return false;
    if (char > 0x39)
        return false;
    return true;
}

fn has_valid_size(cpf: []const u8) bool {
    var counter: i32 = 0;
    for (cpf) |elem| {
        if (is_digit(elem))
            counter += 1;
    }
    return counter == 11;
}
