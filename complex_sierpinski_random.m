
function S = complex_sierpinski_random(level)
% complex_sierpinski_random constructs a 2D Sierpinski gasket graph
% with randomly flipped edge orientations.
%
% INPUT
%   level : recursion level
%
% OUTPUT
%   S{1,1} : vertex indices
%   S{1,2} : vertex coordinates
%   S{2,1} : directed edges after random orientation flipping
%   S{2,2} : empty
%   S{3,1} : empty faces
%   S{3,2} : empty
%
% (C) Moo K. Chung
% University of Wisconsin-Madison
% mkchung@wisc.edu

V = [0 0; 1 0; 0.5 sqrt(3)/2];
E = [1 2; 2 3; 1 3];

for l = 1:level
    Vnew = [];
    Enew = [];
    shifts = [0 0; 0.5 0; 0.25 sqrt(3)/4];

    for s = 1:3
        idx0 = size(Vnew,1);
        Vcopy = 0.5*V + shifts(s,:);
        Ecopy = E + idx0;

        Vnew = [Vnew; Vcopy];
        Enew = [Enew; Ecopy];
    end

    [V,~,ic] = unique(round(Vnew,12),'rows');
    E = ic(Enew);

    E_sorted = sort(E,2);
    [~,ia] = unique(E_sorted,'rows');
    E = E(ia,:);
end

nE = size(E,1);
flip_ind = rand(nE,1) > 0.5;
E(flip_ind,:) = E(flip_ind,[2 1]);

S = cell(3,2);
S{1,1} = (1:size(V,1))';
S{1,2} = V;
S{2,1} = E;
S{2,2} = [];
S{3,1} = [];
S{3,2} = [];

end