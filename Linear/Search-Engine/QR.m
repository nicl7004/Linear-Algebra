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


swag = qnorm'*qnorm
qnorm
r = qnorm'*a
don = qnorm*r;

% [m, n] = size(A);
% Q = zeros(m,n);
% R = zeros(n);
% 
% for k=1:n
%     R(k,k) = norm(A(:,k));
%     
%     Q(:,k) = A(:,k)/R(k,k);
%     
%     R(k,k+1:n) = Q(:,k)'*A(:,k+1:n);
%     
%     A(:,k+1:n) = A(:,k+1:n) - Q(:,k)*R(k,k+1:n);
% end
% 
% Q
% R
% 
% Q'*Q
% Q*R
