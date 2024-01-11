#include <bits/stdc++.h>
#define FAST_IO ios_base::sync_with_stdio(false), cin.tie(NULL), cout.tie(NULL)
#define ll long long

using namespace std;

void part1(const vector<string>& input) {
    // part 1
    int rows = input.size();
    int cols = input[0].size();
    int sum = 0;
    // -1: dot
    // -2: symbol
    // other: number
    vector<vector<int>> grid(rows, vector<int>(cols, -1));
    for (int i = 0; i < rows; ++i) {
        string line = input[i];
        int j = 0;
        while (j < cols) {
            if (line[j] == '.') {
                grid[i][j] = -1;
                ++j;
            } else if (line[j] != '.' && !isdigit(line[j])) {
                grid[i][j] = -2;
                ++j;
            } else {
                int old_j = j;
                int num = 0;
                while (j < cols && isdigit(line[j])) {
                    num = num * 10 + (line[j] - '0');
                    ++j;
                }
                for (int k = old_j; k < j; ++k) {
                    grid[i][k] = num;
                }
            }
        }
    }


    auto set = [&grid](int i, int j) {
        int val = grid[i][j];
        int old_j = j;
        while (j >= 0 && grid[i][j] == val) {
            grid[i][j] = -1;
            --j;
        }
        j = old_j + 1;
        while (j < grid[0].size() && grid[i][j] == val) {
            grid[i][j] = -1;
            ++j;
        }
    };

    vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {-1, -1}, {-1, 1}, {1, -1}};
    for (int i = 0; i < rows; ++i) {
        int j = 0;
        while (j < cols) {
            if (grid[i][j] == -2) {
                for (auto dir : directions) {
                    int x = i + dir.first;
                    int y = j + dir.second;
                    if (x >= 0 && x < rows && y >= 0 && y < cols && grid[x][y] >= 0) {
                        sum += grid[x][y];
                        set(x, y);
                    }
                }
                grid[i][j] = -1;
            }
            ++j;
        }
    }
    
    cout << "Part 1: " << sum << endl;
}

void part2(const vector<string>& input) {
    int rows = input.size();
    int cols = input[0].size();
    int sum = 0;
    // -1: dot
    // -2: symbol
    // other: number
    vector<vector<int>> grid(rows, vector<int>(cols, -1));
    for (int i = 0; i < rows; ++i) {
        string line = input[i];
        int j = 0;
        while (j < cols) {
            if (line[j] == '.') {
                grid[i][j] = -1;
                ++j;
            } else if (line[j] != '.' && !isdigit(line[j])) {
                grid[i][j] = -2;
                ++j;
            } else {
                int old_j = j;
                int num = 0;
                while (j < cols && isdigit(line[j])) {
                    num = num * 10 + (line[j] - '0');
                    ++j;
                }
                for (int k = old_j; k < j; ++k) {
                    grid[i][k] = num;
                }
            }
        }
    }


    auto set = [&grid](int i, int j) {
        int val = grid[i][j];
        int old_j = j;
        while (j >= 0 && grid[i][j] == val) {
            grid[i][j] = -1;
            --j;
        }
        j = old_j + 1;
        while (j < grid[0].size() && grid[i][j] == val) {
            grid[i][j] = -1;
            ++j;
        }
    };

    vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {-1, -1}, {-1, 1}, {1, -1}};
    for (int i = 0; i < rows; ++i) {
        int j = 0;
        while (j < cols) {
            if (input[i][j] == '*') {
                int cnt = 0;
                int prod = 1;
                for (auto dir : directions) {
                    int x = i + dir.first;
                    int y = j + dir.second;
                    if (x >= 0 && x < rows && y >= 0 && y < cols && grid[x][y] >= 0) {
                        // sum += grid[x][y];
                        ++cnt;
                        if (cnt > 2) {
                            prod = 0;
                            break;
                        }
                        prod *= grid[x][y];
                        set(x, y);
                    }
                }
                if (cnt == 2) {
                    sum += prod;
                }
                grid[i][j] = -1;
            }
            ++j;
        }
    }
    
    cout << "Part 2: " << sum << endl;
}


int main(int argc, char const *argv[]) {
	FAST_IO;

    // !TODO: Write your code here
    fstream file(argv[1], ios::in);
    string line;
    vector<string> v;

    while (getline(file, line)) {
        v.push_back(line);
    }
    part1(v);
    part2(v);

	return 0;
}
