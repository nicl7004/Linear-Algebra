## Nicholas Clement
## CSCI 2830 - Search Engine Part Two


## Introduction

This is part two of Application two, a Search Engine that uses cosine comparisons to determine similarity between matrices.  Our goal in this part of the application is to improve on our previous results through QR decomposition to find and remove redundancy in our vector version of the 'database'.

We know mathematically that redundancy in a matrix occurs when its rank is smaller than its number of columns.  This signals that we have at least one linearly dependent column.  We can combat these issues by identifying a basis for the column space, and one way to calculate a basis for the column space is through the Gram-Schmidt process (A = QR).

#### Gram-Schmidt Process in MATLAB:

    `[x, y] = size(A);
    Q = zeros(x,y);
    R = zeros(y);`
    for k=1:y
        R(k,k) = norm(A(:,k));
        Q(:,k) = A(:,k)/R(k,k);
        R(k,k+1:y) = Q(:,k)'* A(:,k+1:y);
        A(:,k+1:y) = A(:,k+1:y) - Q(:,k)* R(k,k+1:y);
    end
#### Explanation:
Start by building Q and R to be their respective sizes.

`[x, y] = size(A);
Q = zeros(x,y);
R = zeros(y);`

Loop through the columns of A


Start by finding r(k,k) via the norm of the a column

  `R(k,k) = norm(A(:,k));`

  Next find the column of Q from A and R

  `Q(:,k) = A(:,k)/R(k,k);`

Update R with Q for next iteration
  `R(k,k+1:y) = Q(:,k)'`

Update A to show A-Q as in section 6.4 of the book

  `A(:,k+1:y) = A(:,k+1:y) - Q(:,k)*R(k,k+1:y);`

#### Results:

Initial Matrix:

|1	|0|	0|	1|	0|
|-|-|-|-|-|
|1|	0|	1|	1|	1|
|1|	0|	0	|1	|0|
|0|	0|	0|	1|	0|
|0|	1|	0|	1|	1|
|0|	0|	0|	1|	0|

Resulting Matrices:

Q:

R:





1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D
## History
TODO: Write history
## Credits
TODO: Write credits
## License
