## Nicholas Clement
## CSCI 2830 - Search Engine Part Two


## Introduction

This is part two of Application two, a Search Engine that uses cosine comparisons to determine similarity between matrices.  Our goal in this part of the application is to improve on our previous results through QR decomposition to find and remove redundancy in our vector version of the 'database'.

We know mathematically that redundancy in a matrix occurs when its rank is smaller than its number of columns.  This signals that we have at least one linearly dependent column.  We can combat these issues by identifying a basis for the column space, and one way to calculate a basis for the column space is through the Gram-Schmidt process (A = QR).

#### Gram-Schmidt Process in MATLAB:
    function don = QR(a)
    %
    % %this script implements the QR factorization as seen in
    % %section 6.4 of the text
    %
    % %A = QR
    % %The vectors v1, . . . , vp are the columns of Q.
    n = size(a,1);
    k = size(a,2);
    U = zeros(n,k);


    U(:,1) = a(:,1)/sqrt(a(:,1)'*a(:,1)); %inital case

    for i = 2:k
        U(:,i) = a(:,i);
        for j = 1:i-1
            U(:,i) = U(:,i) - ((U(:,i)'*U(:,j))*U(:,j));
        end
        (sqrt(U(:,i)'*U(:,i)));
        if (sqrt(U(:,i)'*U(:,i)))~=0
             U(:,i) = U(:,i)/(sqrt(U(:,i)'*U(:,i)));
        end
    end
    %get rid of nan

    %allow us to pick the rank we want
    % for x = r:k
    %     U(:,x) = 0;
    % end


    r = zeros(n,k);
    squares = zeros(n,k);
    qnorm = zeros(n,k);
    U;




    %now we normalize
    %first find squares
    for x = 1:k  
        for y = 1:n

            squares(y,x) = U(y,x)^2;

        end
    end
    %next sum column vectors
    squares;
    for x = 1:k
        su = sum(squares(:,x));

        for y = 1:n
            if su ~=0
                qnorm(y,x) = U(y,x)/(sqrt(su));
            end
        end

    end


    i = qnorm'*qnorm
    qnorm
    r = qnorm'*a
    don = qnorm*r;




#### Results:

Initial Matrix (Database):

|1	|0|	0|	1|	0|
|---|----|----|----|----|
|1|	0|	1|	1|	1|
|1|	0|	0	|1	|0|
|0|	0|	0|	1|	0|
|0|	1|	0|	1|	1|
|0|	0|	0|	1|	0|

Resulting Matrices:

Q (qnorm):

|0.5774 |        0 |  -0.4082 |  -0.0000 |   0|
|----|----|----|----|----|
|    0.5774 |        0  |  0.8165  | -0.0000  | 0|
  |  0.5774|         0  | -0.4082 |  -0.0000 |   0|
  |       0    |     0    |     0 |   0.7071|   -0.0000|
  |       0  |  1.0000   |      0  |       0   |      0|
|         0  |       0  |       0 |   0.7071  | -0.0000|


R:

|1.7321  |       0  |  0.5774  |  1.7321  |  0.5774|
|----|----|----|----|----|
        |0   | 1.0000       |  0  |  1.0000  |  1.0000|
|  -0.0000    |     0  |  0.8165 |  -0.0000  |.8165|
| -0.0000    |     0 |  -0.0000 | 1.4142 |  -0.0000|
|        0    |     0  |       0 |        0 |        0|

We can see that R is an upper triangular matrix, just like expected.

When we multiply Q*R we get A:

A:

|1.0000 |        0 |   0.0000 |   1.0000 |  -0.0000|
|----|----|----|----|----|
    |1.0000 |        0|    1.0000 |   1.0000 |   1.0000|
|    1.0000 |        0 |   0.0000 |   1.0000  | -0.0000|
|   -0.0000 |        0 |  -0.0000 |   1.0000 |  -0.0000|
|         0  |  1.0000 |        0  |  1.0000 |   1.0000|
|   -0.0000 |        0 |  -0.0000 |   1.0000 |  -0.0000|

Q^T*Q:

|1.0000  |       0|   -0.0000|   -0.0000|         0|
|----|----|----|----|----|
         |0  |  1.0000     |    0    |     0    |     0|
  | -0.0000 |        0 |   1.0000 |       0  |       0|
  | -0.0000|         0 |        0  |  1.0000  |     0|
|         0   |      0   |      0   |     0 |        0|

We see above the last 1 in the identity matrix getting cut off.  This may be a result of our rank reduction in QR decomposition.


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
