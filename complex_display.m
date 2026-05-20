function h = complex_display(S)
% complex_display displays a 2D directed simplicial complex.
%
% INPUT
%   S{1,1} : vertex indices
%   S{1,2} : vertex coordinates
%   S{2,1} : directed edges
%   S{3,1} : faces, optional
%
% OUTPUT
%   h : figure handle
%
% (C) 2026 Moo K. Chung
% University of Wisconsin-Madison
% mkchung@wisc.edu

V = S{1,2};
E = S{2,1};

h = figure;

if size(S,1) >= 3 && ~isempty(S{3,1})
    F = S{3,1};
    patch('Faces',F,'Vertices',V, ...
          'FaceColor',[0.90 0.90 0.90], ...
          'EdgeColor',[0.75 0.75 0.75]);
    hold on
else
    X = [V(E(:,1),1) V(E(:,2),1) nan(size(E,1),1)]';
    Y = [V(E(:,1),2) V(E(:,2),2) nan(size(E,1),1)]';
    line(X(:),Y(:),'Color',[0.75 0.75 0.75],'LineWidth',1)
    hold on
end

plot(V(:,1),V(:,2),'k.','MarkerSize',8)

p1 = V(E(:,1),:);
p2 = V(E(:,2),:);

mid = 0.5*(p1+p2);
vec = 0.35*(p2-p1);

quiver(mid(:,1)-vec(:,1)/2, mid(:,2)-vec(:,2)/2, ...
       vec(:,1), vec(:,2), 0, ...
       'k','LineWidth',2,'MaxHeadSize',0.8)

axis equal off
set(gca,'FontSize',16,'LineWidth',1.5)
end