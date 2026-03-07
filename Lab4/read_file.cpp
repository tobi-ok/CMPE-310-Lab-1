#include <iostream>
#include <fstream>
#include <vector>
using namespace std;

extern "C" int sum_array(int *arr, long n);

int main(){
    string fileName = "Lab4/data.txt";
    ifstream intFile(fileName);

    if (!intFile.is_open()){
        cout << "Failed to open " << fileName << endl;
        return 1;
    }

    int amount;
    intFile >> amount; // Read file line to know amount of integers in file

    std::vector<int> numbers;
    int val;
    for (int i = 0; i < amount; i++){
        if (intFile >> val){
            numbers.push_back(val);
        }
    }

    int total = sum_array(numbers.data(), numbers.size());

    cout << "The sum of integers is: " << total << endl;

    return 0;
}