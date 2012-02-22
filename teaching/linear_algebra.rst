Notes on Linear Algebra given to my students
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

These are some notes on Linear Algebra which I prepared for a group of students I was teaching. They are in no way
complete but they aim to clarify some common misconceptions and provide a solid basis for further study.

Matrix vector multiplication
============================

I find it confusing to think about vectors and matrices as seas of numbers. Instead I find it simpler, and more
geometrically intuitive, to see them as stacked sets of row or column vectors. This is the approach I’ll use in these
notes and is also one I suggest you attempt to master.  It can often reduce a linear algebra proof to a few lines.

Left-multiplication
-------------------

A :math:`1 \times N` vector, :math:`\vec{x}`, multiplied by a :math:`N \times M` matrix, :math:`A`, gives a :math:`1
\times M` vector which is the dot product of :math:`\vec{x}` with the *columns* of :math:`A`.

.. math::

    \newcommand{\hmatrixrule}{\vcenter{\overline{\Space{2em}{0pt}{0pt}}}}
    \newcommand{\vmatrixrule}{\vcenter{\Space{0.3ex}{2em}{0pt}}\left\vert\Space{0pt}{1em}{0pt}\right.}

    \begin{array}{cccc}
    \left[
    \begin{array}{cccc}
    \hmatrixrule & \vec{x} & \hmatrixrule 
    \end{array} \right] &
    \left[
    \begin{array}{cccc}
    \vmatrixrule & \vmatrixrule &  & \vmatrixrule \\
    \vec{a}_1 & \vec{a}_2 & \cdots & \vec{a}_M \\
    \vmatrixrule & \vmatrixrule &  & \vmatrixrule 
    \end{array}
    \right] &
    = &
    \left[ \begin{array}{cccc}
    \vec{x} \cdot \vec{a}_1 & \vec{x} \cdot \vec{a}_2 & \cdots & \vec{x} \cdot \vec{a}_M
    \end{array} \right] 
    \\
    \Space{0pt}{2em}{0pt}
    1 \times N & N \times M & \rightarrow & 1 \times M
    \end{array}

Right-multiplication
--------------------

A :math:`N \times M` matrix, :math:`A`, multiplied by a :math:`M \times 1` vector, :math:`\vec{x}`, gives a :math:`N
\times 1` vector which is the dot product of :math:`\vec{x}` with the *rows* of :math:`A`.

.. math::

    \begin{array}{cccc}
    \left[
    \begin{array}{ccc}
    \hmatrixrule & \vec{a}_1 & \hmatrixrule \\
    \hmatrixrule & \vec{a}_2 & \hmatrixrule \\
    & \vdots & \\
    \hmatrixrule & \vec{a}_N & \hmatrixrule
    \end{array}
    \right] &
    \left[
    \begin{array}{c}
    \vmatrixrule \\
    \vec{x} \\
    \vmatrixrule 
    \end{array}
    \right] &
    = &
    \left[
    \begin{array}{c}
    \vec{a}_1 \cdot \vec{x} \\ \vec{a}_2 \cdot \vec{x} \\ \vdots \\ \vec{a}_N \cdot \vec{x}
    \end{array}
    \right]
    \\
    \Space{0pt}{2em}{0pt} N \times M & M \times 1 & \rightarrow & N \times 1
    \end{array}

The four fundamental subspaces
------------------------------

The row space
~~~~~~~~~~~~~

The row space of a :math:`N \times M` matrix, :math:`A`, is the :math:`M`-component space spanned by the *rows* of
:math:`A`. If :math:`\vec{x}` is in the row space of :math:`A` then at least one of :math:`\vec{x} \cdot \vec{a}_i`,
where :math:`\vec{a}_i` is a row of :math:`A`, *must* be non-zero by definition. The *dimension* of the row space is
equal to the rank of the matrix.

The null space
~~~~~~~~~~~~~~

The null space of a :math:`N \times M` matrix, :math:`A`, is the :math:`M`-component space of vectors, :math:`\vec{x}`,
for which :math:`A\vec{x} = \vec{0}`. Looking at our definition of the row space, it is clear that if a vector is in the
row space it *cannot* be in the null space and *vice versa*. Therefore the row space is the *compliment* of the row
space.

The column space
~~~~~~~~~~~~~~~~

The column space of a :math:`N \times M` matrix, :math:`A`, is the :math:`N`-component space spanned by the *columns* of
:math:`A`. If :math:`\vec{x}` is in the column space of :math:`A` then at least one of :math:`\vec{x} \cdot \vec{a}_i`,
where :math:`\vec{a}_i` is a column of :math:`A`, *must* be non-zero by definition. The *dimension* of the column space
is equal to the rank of the matrix.

The left null space
~~~~~~~~~~~~~~~~~~~

The left null space of a :math:`N \times M` matrix, :math:`A`, is the :math:`N`-component space of vectors,
:math:`\vec{x}`, for which :math:`\vec{x}^TA = \vec{0}^T`. Looking at our definition of the column space, it is clear
that if a vector is in the column space it *cannot* be in the left null space and *vice versa*.  Therefore the column
space is the *compliment* of the left null space.

The rank of a matrix
~~~~~~~~~~~~~~~~~~~~

The rank of a matrix is an important concept. As we have seen, if a matrix is not *full-rank* then the left-null space
and null space must be non-zero and so some information from a vector will always be ‘thrown away’ (or set to zero) by
the matrix.

Matrix-matrix multiplication
============================

Like matrix-vector multiplication, it is best to think of this as a set of row-wise and column-wise operations.

.. math::
    \begin{array}{cccc}
    \left[
    \begin{array}{ccc}
    \hmatrixrule & \vec{a}_1 & \hmatrixrule \\
    \hmatrixrule & \vec{a}_2 & \hmatrixrule \\
    & \vdots & \\
    \hmatrixrule & \vec{a}_N & \hmatrixrule
    \end{array}
    \right] &
    \left[
    \begin{array}{cccc}
    \vmatrixrule & \vmatrixrule &  & \vmatrixrule \\
    \vec{b}_1 & \vec{b}_2 & \cdots & \vec{b}_M \\
    \vmatrixrule & \vmatrixrule &  & \vmatrixrule 
    \end{array}
    \right] &
    = &
    \left[
    \begin{array}{cccc}
    \vec{a}_1 \cdot \vec{b}_1 & \vec{a}_1 \cdot \vec{b}_2 & \cdots & \vec{a}_1 \cdot \vec{b}_M \\
    \vec{a}_2 \cdot \vec{b}_1 & \vec{a}_2 \cdot \vec{b}_2 & \cdots & \vec{a}_2 \cdot \vec{b}_M \\
    \vdots & \vdots & \ddots & \vdots \\
    \vec{a}_N \cdot \vec{b}_1 & \vec{a}_N \cdot \vec{b}_2 & \cdots & \vec{a}_N \cdot \vec{b}_M 
    \end{array}
    \right]
    \\
    \Space{0pt}{2em}{0pt} N \times L & L \times M & \rightarrow & N \times M
    \end{array}

Orthonormal matrices
--------------------

An orthonormal matrix is one where all columns are independent and have unit length. If :math:`\{ \vec{a}_i : i \in 1
\dots M \}` are the columns of an orthonormal matrix then it follows from the definition that

.. math::
  \vec{a}_i \cdot \vec{a}_i = 1, \quad \vec{a}_i \cdot \vec{a}_j = 0 \qquad
  \forall \  i, j \in 1 \dots M.

By using this result and looking at our representation of matrix-matrix multiplication above it should be clear that, if
:math:`Q` is an orthonormal matrix, :math:`Q^TQ = I` and hence the transpose of an orthonormal matrix is its
inverse.

The rows of :math:`Q`
~~~~~~~~~~~~~~~~~~~~~~~

Further, if :math:`Q^T` is the inverse of :math:`Q`, then :math:`QQ^T = I` and hence :math:`Q^T` must itself be
orthonormal.  Since, by definition of an orthonormal matrix, the columns of :math:`Q^T` are independent and have unit
length then it follows that the rows of an orthonormal matrix are *also* independent and unit length.

The geometric interpretation of orthonormal matrices
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The geometric interpretation of the action of an orthonormal matrix can easily be seen by considering the actions of an
:math:`N \times M` orthonormal matrix :math:`Q` with *rows* :math:`\{ \vec{q}_i : i \in 1 \dots N \}` on a :math:`M
\times 1` vector :math:`\vec{x}`. Each component of :math:`Q\vec{x}` is :math:`\vec{x}` *resolved* onto one of the rows
of :math:`Q`. Since the rows of :math:`Q` are independent and have unit length, this results in a change of co-ordinates
for :math:`\vec{x}`, resolving it onto the basis formed by the rows of :math:`Q`. In summary, an :math:`N \times M`
orthonormal matrix resolved a :math:`M`-component vector into a :math:`N`-dimensional subspace and a square
orthonormal matrix transforms from one co-ordinate system to another without a loss of information. This last statement
also justifies our implicit assertion above that all square orthonormal matrices are invertible.

Eigenvalues and eigenvectors
============================

An *eigenvector*, :math:`\vec{v}`, of some square matrix, :math:`A`, is defined to be any vector for which :math:`A
\vec{v} = \lambda \vec{v}`. By *convention* we choose that eigenvectors have unit length although we are in general free
to choose the length of eigenvectors. The value :math:`\lambda` is an *eigenvalue* of the matrix, :math:`A`. We do not
consider the vector :math:`\vec{0}` to be an eigenvector of a matrix since it trivially satisfies the requirements for
all square matrices.

A *left-eigenvector* of some square matrix, :math:`A`, is a vector, :math:`\vec{v}`, which satisfies :math:`\vec{v}^T A
= \lambda \vec{v}^T`. It is obvious that the eigenvectors of a matrix are the left-eigenvectors of its transpose.

Eigenvectors of symmetric matrices
----------------------------------

In general eigenvectors need not be orthogonal to each other but there is a special case where they are. Suppose the
square matrix, :math:`A`, is symmetric so that :math:`A^T = A`. In this case the left-eigenvectors and left-eigenvalues
are the same as the eigenvectors and eigenvalues.

Suppose two eigenvectors, :math:`\vec{e}_1` and :math:`\vec{e}_2` with associated eigenvalues :math:`\lambda_1` and
:math:`\lambda_2`, were non-orthogonal. In which case, we could represent one as some offset from the other:
:math:`\vec{e}_2 = \alpha \vec{e}_1 + \vec{\Delta}` where :math:`\vec{e}_1 \cdot \vec{\Delta} = 0`. Now consider
multiplying :math:`A` on the right by :math:`\vec{e}_2`:

.. math:: 
    A \vec{e}_2 = \lambda_2 \vec{e}_2
    = \lambda_2 \alpha \vec{e}_1 + \lambda_2 \vec{\Delta}
    \qquad\text{and}\qquad
    A \vec{e}_2 = A \vec{e}_1 + A \vec{\Delta}
    = \lambda_1 \vec{e}_1 + A \vec{\Delta}.

By this result and the orthogonality of :math:`\vec{e}_1` and :math:`\vec{\Delta}` it follows that :math:`A\vec{\Delta}
= \lambda_2 \vec{\Delta}`. Hence, by definition, :math:`\vec{e}_2 = \vec{\Delta}` and is orthogonal to
:math:`\vec{e}_1`.

This is a sketch proof and is non-rigorous but provides a justification for the claim that the eigenvectors of a
symmetric matrix are orthogonal. A rigorous proof adds the condition that the matrix be of a form known as positive
semi-definite but this is beyond the scope of the course.

Relation to the fundamental subspaces of a matrix
-------------------------------------------------

Looking at the definition of right-multiplication above it should be clear that if a *non-zero* vector :math:`\vec{b}`
can be expressed via another vector :math:`\vec{x}` applied to :math:`A` so that :math:`A\vec{x} = \vec{b}` then
:math:`\vec{x}` is in the row space of the matrix. In other words, :math:`\vec{x}` is non-orthogonal to at least one row
of :math:`A` since :math:`\vec{b}` has at least one non-zero component.a By a similar argument, if :math:`\vec{x}^T A =
\vec{b}^T` and :math:`\vec{b}` is non-zero, then :math:`\vec{x}` must be in the *column space* of :math:`A`.

It follows that all eigenvectors of a square matrix must be in the row space and all left-eigenvectors of a square
matrix must be in the column space. Since, for a symmetric matrix, the left-eigenvectors are the same as the
eigenvectors, for a symmetric matrix, the eigenvectors must lie in *both* the column space and the row space.

As the eigenvectors for a symmetric matrix must be orthogonal and are by convention unit length, it may be no surprise
to you that the eigenvectors of a symmetric matrix form an orthonormal basis for the row and column spaces. It is
instructive to attempt to show this. It may be done quite simply using a similar method to that used to show the
orthogonality of a symmetric matrix’s eigenvectors above: consider some vector composed of multiples of the eigenvectors
and a remainder term orthogonal to all eigenvectors and then right-multiply the matrix by it.

Since the eigenvectors of a symmetric basis span the column and row spaces and since they are orthonormal, it should be
cleat that the number of eigenvectors for a symmetric matrix equals its rank.

The eigenvector decomposition
-----------------------------

Consider some :math:`N \times M` matrix, :math:`A`. We can form two symmetric matrices from it: the :math:`N \times N`
matrix :math:`AA^T` and the :math:`M \times M` matrix :math:`A^TA`. If :math:`V` is a matrix whose columns are
eigenvectors of :math:`A^TA` and :math:`U` is a matrix whose columns are eigenvectors of :math:`AA^T` then, by
definition,

.. math::

    A^TA V = V \Lambda_V, \qquad AA^T U = U \Lambda_U,
    
where :math:`\Lambda_V` and :math:`\Lambda_U` are matrices whose diagonal elements containing the appropriate
eigenvalues. The size of :math:`\Lambda_U` and :math:`\Lambda_V` depend on the *ranks* of :math:`AA^T` and :math:`A^TA`
respectively. If you look up the properties of ranks, you’ll discover that the ranks of :math:`A^TA` and :math:`AA^T`
are equal to the rank of :math:`A`. Let’s call it :math:`R`. In this case, therefore, the matrices :math:`\Lambda_U` and
:math:`\Lambda_V` are :math:`R \times R`, where :math:`R = \mbox{rank}(A)`.

Since we know that :math:`V` and :math:`U` are orthonormal, their
inverses must be their own transpose and so we can rearrange the above
as follows:

.. math:: A^TA = V \Lambda_V V^T, \qquad AA^T = U \Lambda_U U^T.

This is called the *eigenvector decomposition* of :math:`A`.

Eigenvalues of :math:`AA^T` and :math:`A^TA`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Imagine, for the moment, that :math:`\vec{v}` is an eigenvector of :math:`A^TA` with associated eigenvalue
:math:`\lambda_v`. Then, by the definition,

.. math::
    A^TA\vec{v} = \lambda_v \vec{v}
    \quad \Rightarrow \quad
    AA^TA\vec{v} = \lambda_v A\vec{v}.

Hence if :math:`\vec{v}` is an eigenvector or :math:`A^TA`, then :math:`A\vec{v}` is an eigenvector of :math:`AA^T` with
the same eigenvalue. Similarly, if :math:`\vec{u}` is an eigenvector of :math:`AA^T` then :math:`A^T\vec{u}` is an
eigenvector of :math:`A^TA` with the same eigenvalue. In summary, the eigenvalues of :math:`A^TA` and :math:`AA^T` are
identical.

Because of this, we can always *choose* the ordering of :math:`U` and :math:`V` so as to make the diagonal terms of
:math:`\Lambda_U` and :math:`\Lambda_V` identical and hence make both matrices equal to some diagonal matrix
:math:`\Lambda`. The way this is done is that, conventionally, the columns of :math:`U` and :math:`V` are ordered by
decreasing eigenvalue.

In summary, when the columns of :math:`U` and :math:`V` are arranged in decreasing order of eigenvalue, we may form two
related eigenvector decompositions of :math:`A`:

.. math:: A^TA = V \Lambda V^T, \qquad AA^T = U \Lambda U^T.

Since each eigenvector of :math:`AA^T` maps to an eigenvector of :math:`A^TA` and vice-versa, we can be confident that
the ranks of :math:`AA^T` and :math:`A^TA` are identical. This is yet more justification of the assertion about the
sizes of :math:`\Lambda_U`
and :math:`\Lambda_V` above.

The singular value decomposition
--------------------------------

For the moment, suppose that there is some decomposition of an :math:`N \times M` matrix :math:`A` into a :math:`N
\times R` orthogonal matrix :math:`U`, a :math:`M \times R` matrix :math:`V` and some :math:`R \times R` matrix
:math:`\Sigma` whose only non-zero terms are on the diagonal:

.. math:: A = U \Sigma V^T.

Consider the form of the matrices :math:`A^TA` and :math:`AA^T`:

.. math::

    A^TA = V \Sigma^T U U^T \Sigma V^T = V \Sigma^T \Sigma V^T, \qquad
    AA^T = U \Sigma V^T V \Sigma^T U = U \Sigma \Sigma^T U^T.

If we make the observation that we may set :math:`\Sigma^T \Sigma = \Lambda_V` and :math:`\Sigma \Sigma^T = \Lambda_U`
then we have exactly the eigenvector decomposition. Further, since :math:`\Lambda_U = \Lambda_V = \Lambda`, then we can
see that :math:`\Sigma` is the :math:`R \times R` diagonal matrix of eigenvalue square-roots.

The decomposition :math:`A = U \Sigma V^T` is called the *singular value decomposition* (SVD). The columns of the
matrices :math:`U` and :math:`V` are the eigenvectors of :math:`AA^T` and :math:`A^TA` respectively ordered by
decreasing eigenvalue. The non-zero elements of :math:`\Sigma` are called the singular values and the number of
singular values is equal to the rank of :math:`A`.

The geometric interpretation of the SVD
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We can interpret the SVD of a :math:`N \times M` matrix geometrically.  The action of the first orthonormal matrix
:math:`V^T` is to transform a :math:`M`-component vector into a :math:`R`-dimensional subspace.  This will lose
information if :math:`R < M`. In this subspace, the action of the matrix :math:`A` is to scale along each of the basis
vectors by the values of the diagonal of :math:`\Sigma`. Finally, the orthonormal matrix :math:`U` transforms from the
:math:`R`-dimensional subspace into the :math:`U`-component space we expect the result to be in. This transform cannot
invent new information; the result of applying :math:`U` is still :math:`R`-dimensional, it is just a
:math:`R`-dimensional subspace embedded in a :math:`N`-dimensional space.

It is this ‘necking’ into a :math:`R`-dimensional space that shows up if the matrix :math:`A` is invertible in and of
itself. If :math:`R < M` information will be lost and so the matrix could never be invertible.

Matrix approximation
~~~~~~~~~~~~~~~~~~~~

The SVD may be used to approximate a matrix. Instead of retaining the full :math:`R` diagonal entries of :math:`\Sigma`,
we may truncate the matrix and keep only the first :math:`R' < R` entries of :math:`\Sigma` and the first :math:`R'`
columns of :math:`U` and :math:`V`. The following figures give an example of this so-called *rank reduction* applied to a
matrix representing an image. Under each image is shown the number of singular values (s.v.s) retained and the
corresponding amount of storage required for the image as a fraction of the original.  The SVD can be used as a naïve
form of image compression; we managed to get to around 16% of the original image’s storage by setting :math:`R' = 0.1
R`.

.. figure:: linear_algebra/svd_original.*
    :align: center

    Original (100% storage)

.. .. figure:: linear_algebra/svd_50.*
..     :align: center
.. 
..     50% of s.v.s (82% storage)

.. figure:: linear_algebra/svd_25.*
    :align: center

    25% of s.v.s (41% storage)

.. figure:: linear_algebra/svd_10.*
    :align: center

    10% of s.v.s (16% storage)

.. figure:: linear_algebra/svd_5.*
    :align: center

    5% of s.v.s (8% storage)

.. figure:: linear_algebra/svd_1.*
    :align: center

    1% of s.v.s (2% storage)
