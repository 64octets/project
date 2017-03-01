function W=circulant(vec)

%Determine legnth of vec
N=length(vec);

%Build index
index=find(vec);
diagFact=N+1;
tmp=(diagFact).*(0:(N-1));
masterIndex=index'*ones(1,N) + ones(length(index),1)*tmp;
masterIndex(find(masterIndex>(N^2)))=masterIndex(1);

%Build A
[i,j] = ind2sub([N N],masterIndex(:));
lowerIndex=find(j<=i);
W=sparse(i(lowerIndex),j(lowerIndex),1,N,N);
W=spones(W+W');

%If vec is not sparse, make full again
if ~issparse(vec)
   W=full(W);
end
