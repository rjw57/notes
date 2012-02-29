Find the grey and black areas
=============================

Question
--------

The figure below shows a butterfly badge design bounded by a square with side-length of 2. The design is comprised of
four touching semi-circles and two inscribed circles. Find the grey and black areas.

.. tikz::
    :libs: arrows, calc

    \begin{scope}[x=1.5in, y=1.5in, thin]

    %% grey area
    \begin{scope}[fill=gray]
    \clip 
    (2,0) arc[start angle=270, end angle=90, radius=1] -- (2,0)  %% right
    (0,0) arc[start angle=-90, end angle=90, radius=1] -- (0,0); %% left
    \fill (0,0) arc[start angle=180, end angle=0, radius=1];   %% bottom
    \end{scope}

    %% black area
    \pgfmathsetmacro{\holeradius}{1-1/sqrt(2)}
    \begin{scope}[fill=black, even odd rule]
    \clip
    (2,0) arc[start angle=270, end angle=90, radius=1] -- cycle  %% right
    (0,0) arc[start angle=-90, end angle=90, radius=1] -- cycle  %% left
    (0.5,1.5) circle (\holeradius) (1.5,1.5) circle (\holeradius);
    \fill (0,2) arc[start angle=180, end angle=360, radius=1]; %% top
    \end{scope}

    %% boundaries
    \draw (0,0) rectangle (2,2);
    \draw (0,2) arc[start angle=180, end angle=360, radius=1]; %% top
    \draw (2,0) arc[start angle=270, end angle=90, radius=1];  %% right
    \draw (0,0) arc[start angle=180, end angle=0, radius=1];   %% bottom
    \draw (0,0) arc[start angle=-90, end angle=90, radius=1];  %% left

    %% quadrant
    \begin{scope}[xshift=3.5in, yshift=0.75in]
    \node[below left] at (0,0) {$A$};
    \node[above left] at (0,1) {$B$};
    \node[above right] at (1,1) {$C$};
    \node[below right] at (1,0) {$D$};

    \pgfmathsetmacro{\eradius}{sqrt(2)-1}
    \node[right] at ($ (1,0) + (xy polar cs:angle=135, radius=\eradius)$) {$E$};

    \draw (0,0) rectangle (1,1); %% boundary
    \draw (0,0) arc[start angle=180, end angle=90, radius=1]; %% upper circle
    \draw (0,0) arc[start angle=-90, end angle=0, radius=1]; %% lower circle

    \draw[-latex] (1,0) -- ++ (xy polar cs:angle=135, radius=1) node [above left] {$R$};

    \end{scope}

    \end{scope}

Solution
--------

.. default-role:: math

Consider a single quadrant `ABCD` of the larger figure above. This quadrant is, by symmetry, congruent to any other
quadrant. The grey area is twice that of the area bounded by the two arcs `ARC` and `AEC`. This area, being the overlap
of the circle segments `ABC` and `ADC`, and since `|DR| = |AD| = |AB| = 1`, is given by:

.. math::

    A_1 = 2 \cdot \frac{1}{4} \cdot \pi - 1 = \frac{\pi}{2} - 1.

The grey area is therefore `2A_1` or

.. math::

    A_2 = \pi - 2 = 1.14159\ldots.

Computing the black area above is easy once the diameter `|RE|` has been computed. By symmetry, `|DR| = |BE| = 1`. Since
`|BD| = \sqrt{2}` and `B`, `R`, `E` and `D` are co-linear, it follows that

.. math::

    |RE| = |BE| + |DR| - |BD| = 2 - \sqrt{2}.

The radius of the circles within the black area are therefore both `1 - 1/\sqrt{2}` and hence the black area is given by

.. math::

    A_3 = A_2 - 2 \left( \pi \left[1 - \frac{1}{\sqrt{2}}\right]^2 \right)
    = 2 \left[ \left( \sqrt{2} - 1 \right ) \pi - 1 \right]
    = 0.60258\ldots.
    
