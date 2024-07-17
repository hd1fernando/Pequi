const std = @import("std");

pub fn main() !void {
    _ = is_valid("30877598134");
}

pub fn is_valid(cpf: []const u8) bool {
    if (is_only_digits(cpf) == false)
        return false;
    if (has_valid_size(cpf) == false)
        return false;
    const new_cpf = remove_mask(cpf);
    if (has_only_same_digits(new_cpf))
        return false;
    if (fist_digit_is_valid(new_cpf) == false)
        return false;
    return true;
}

fn fist_digit_is_valid(cpf: []const u8) bool {
    var result: i32 = 0;
    var muiltiplier: i32 = 10;
    for (cpf) |elem| {
        std.debug.print("elem {d}\n", .{@as(i32, elem)});
        std.debug.print("calculating {d} * {d} = {d}\n", .{ @as(i32, elem - 48), @as(i32, muiltiplier), @as(i32, elem - 48) * @as(i32, muiltiplier) });
        result += @as(i32, elem - 48) * @as(i32, muiltiplier);
        muiltiplier -= 1;
        if (muiltiplier < 2) {
            break;
        }
    }
    std.debug.print("result  is {d}\n", .{result});
    const result_times_ten: i32 = result * @as(i32, 10);
    var mod: i32 = @rem(result_times_ten, @as(i32, 11));
    std.debug.print("mod is {d}\n", .{mod});
    std.debug.print("9 is {d}\n", .{cpf[9] - 48});
    if (mod == 10)
        mod = 0;
    return (cpf[9] - 48) == mod;
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
