#include<bits/stdc++.h>
using namespace std;

int main(){
    string s;
    while (getline(cin, s)){
        string out;
        for (int i = 0; i < s.size(); i++){
            if (s[i] == '\\') out += '\\';
            out += s[i];
        }
        cout << out << endl;
    }
}