function Hodge = hodge_laplacian(B,k)
% HODGE_LAPLACIAN computes the k-Hodge Laplacian from boundary matrices.
%
% INPUT
%   B : cell array of sparse boundary matrices
%       B{1} : edge-to-vertex boundary
%       B{2} : triangle-to-edge boundary
%       B{3} : tetrahedron-to-triangle boundary
%
%   k : simplex dimension
%
% OUTPUT
%   Hodge : sparse k-Hodge Laplacian
%
% (C) 2026- Moo K. Chung
%     University of Wisconsin-Madison
%     mkchung@wisc.edu


if k == 0
    Hodge = B{1} * B{1}';
else
    Hodge = B{k}' * B{k};

    if length(B) >= k+1 && ~isempty(B{k+1})
        Hodge = Hodge + B{k+1} * B{k+1}';
    end
end

Hodge = sparse(Hodge);
end