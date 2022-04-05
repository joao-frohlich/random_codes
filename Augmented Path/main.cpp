#include <bits/stdc++.h>
using namespace std;

vector<int> match, vis;
vector<vector<int>> AL;

int Aug(int L) {
    cout << endl << "Running Aug for " << L << endl;
    if (vis[L]) {
        cout << "Visited " << L << ". Returning 0" << endl << endl;
        return 0;
    }
    cout << "Unvisited " << L << endl;
    vis[L] = 1;
    for (auto &R : AL[L]) {
        cout << "Testing " << R << " as R" << endl;
        if (match[R] == -1) {
            cout << "No matching found for " << R
                 << ". Creating matching between " << L
                 << " and " << R << endl;
            match[R] = L;
            cout << "Returning 1 for " << L << endl << endl;
            return 1;
        } else {
            cout << "Found matching for " << R << ": " << match[R] << endl;
            if (Aug(match[R])) {
                cout << "Aug for " << match[R] << " returned 1. "
                     << "Creating matching between " << L << " and " << R << endl; 
                match[R] = L;
                cout << "Returning 1 for " << L << endl << endl;
                return 1;
            }
        }
    }
    cout << "No matching found. Returning 0 for " << L << endl << endl;
    return 0;
}

int main() {
    int V = 8, Vleft = 4;
    AL.assign(V, vector<int>());
    AL[0].push_back(4);
    AL[0].push_back(5);
    AL[1].push_back(4);
    AL[1].push_back(5);
    AL[1].push_back(6);
    AL[2].push_back(6);
    AL[2].push_back(7);
    AL[3].push_back(6);
    AL[3].push_back(7);
    match.assign(V, -1);
    int MCBM = 0;
    for (int L = 0; L < Vleft; L++) {
        cout << "L: " << L << endl;
        vis.assign(Vleft, 0);
        MCBM += Aug(L); 
        cout << endl << endl << endl;
    }
    cout << "Found " << MCBM << " matchings" << endl;
    for (int R = Vleft; R < V; R++) {
        cout << "L: " << match[R] << "; R: " << R << endl;
    }
}

// Example graph
/*
0: [4, 5]
1: [4, 5, 6]
2: [6, 7]
3: [6, 7]
*/
