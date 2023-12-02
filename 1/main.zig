const std = @import("std");

pub fn main() !void {
    // !TODO
    var args = std.process.args();
    _ = args.skip();

    const file_path = args.next().?;

    const stdout = std.io.getStdOut().writer();
    const file = try std.fs.cwd().openFile(file_path, .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    const reader = buf_reader.reader();
    var buffer: [1024]u8 = undefined;
    var sum: usize = 0;
    const nums = [_][]const u8{
        "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    };

    while (try reader.readUntilDelimiterOrEof(buffer[0..], '\n')) |line| {
        var first_found = false;
        var second_found = false;
        var first: usize = undefined;
        var second: usize = undefined;
        var i: usize = 0;
        while (i < line.len and !first_found) {
            const c = buffer[i];
            if (c >= '0' and c <= '9') {
                first_found = true;
                first = c - '0';
                break;
            } else {
                for (0.., nums) |j, num| {
                    if (i + num.len > line.len) {
                        continue;
                    }
                    if (std.mem.eql(u8, line[i .. i + num.len], num)) {
                        first_found = true;
                        first = j;
                        break;
                    }
                }
            }
            i += 1;
        }
        i = line.len - 1;
        while (i >= 0 and !second_found) {
            const c = buffer[i];
            if (c >= '0' and c <= '9') {
                second_found = true;
                second = c - '0';
                break;
            } else {
                for (0.., nums) |j, num| {
                    if (i + num.len > line.len) {
                        continue;
                    }
                    if (std.mem.eql(u8, line[i .. i + num.len], num)) {
                        second_found = true;
                        second = j;
                        break;
                    }
                }
            }
            if (i == 0) {
                break;
            } else {
                i -= 1;
            }
        }
        sum += first * 10 + second;
    }
    try stdout.print("{}\n", .{sum});
}
