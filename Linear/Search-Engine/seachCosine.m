function indlist = searchCosine(a, q, tol)
% This script returns a list of the column indices of
% the columns of the term-by-document matrix a that
% make an angle with q having cosine greater than tol.
[m,n] = size(a);
% normalize q, leave ; off to repeat query
q = q/norm(q)
% normalize a
for j = 1:n
    na(:,j) = a(:,j)/norm(a(:,j));
end
% get cosines
cosvec = na.'*q;
% make list of indices
indlist = [];
for j = 1:n
if (cosvec(j) >= tol) indlist = [indlist j]; end
end
% print indlist
cosvec
indlist