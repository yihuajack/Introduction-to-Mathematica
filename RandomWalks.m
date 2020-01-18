(* ::Package:: *)

(* ::Input:: *)
(*FactorInteger[5,GaussianIntegers->True]*)


(* ::Input:: *)
(*Factor[27x^5+81x^4y+9x^3y^2-73x^2y^3+32x y^4-4y^5]*)


(* ::Input:: *)
(*Options[Walk2D]={LatticeWalk->True}*)


(* ::Input:: *)
(*?Walk2D*)


(* ::Input:: *)
(*lattice=LatticeWalk/.{opts}/.Options[Walk2D];*)


(* ::Input:: *)
(*Walk2D[n_,opts_]:=Module[{lattice},*)
(*lattice=LatticeWalk/.{opts}/.Options[Walk2D];*)
(*If[lattice==True,*)
(*FoldList[Plus,{0,0},*)
(*{{0,1}{1,0}{0,-1}{-1,0}}[[*)
(*Table[Random[Integer,{1,4}],{n}]]]],*)
(*FoldList[Plus,{0,0},*)
(*Map[({Sin[#],Cos[#]})&,*)
(*Table[Random[Real,{0,N[2Pi]}],{n}]]*)
(*]]]*)


(* ::Input:: *)
(*Walk2D[4]*)


(* ::Input:: *)
(*Walk2D[4,LatticeWalk->False]*)


(* ::Input:: *)
(*BeginPackage["RandomWalks`"]*)


(* ::Input:: *)
(*Needs["Graphics`ArgColors`"]*)


(* ::Input:: *)
(*Walk1D::usage="Walk1D[n] generates an n-step walk*)
(*in one dimension. Steps are of unit length.";*)


(* ::Input:: *)
(*Walk2D::usage="Walk2D[n] generates an n-step walk*)
(*in two dimensions. The Default behavior gives a lattice*)
(*walk with steps in one of the four compass directions.*)
(*Setting the option LatticeWalk->False will generate an*)
(*off-lattice walk.";*)


(* ::Input:: *)
(*Walk3D::usage="Walk3D[n] Conterates an n-step walk in*)
(*three dimensions. The walk is executed on a cubic lattice*)
(*with each step in one of 8 lattice directions.";*)


(* ::Input:: *)
(*LatticeWalk::usage="LatticeWalk->val is an option*)
(*to Walk2D that determines whether the random walk will*)
(*be a lattice walk or an off-lattice walk. Possible values*)
(*are True and False.";*)


(* ::Input:: *)
(*SquareDistance::usage="SquareDistance[walk] computes*)
(*The square of the end-to-end distance of a two-dimensional*)
(*Lattice walk. This can be thought of as the square of the*)
(*diameter of the walk.";*)


(* ::Input:: *)
(*MeanSquareDistance::usage="MeanSquareDistance[n,m]*)
(*Computes the mean square end-to-end distance of m n-step*)
(*lattice walks.";*)


(* ::Input:: *)
(*MeanSquareRadiusGyration::usage=*)
(*"MeanSquareRadiusGyration[m,n] computes the mean*)
(*square radius of gyration of a random walk. This is the*)
(*sum of the squares of the distances of the step*)
(*Locations from the center of mass, divided by the*)
(*number of step locations, where the center of mass is*)
(*the sum of the step locations divided by the number of*)
(*step locations.";*)


(* ::Input:: *)
(*ShowWalk2D::usage="ShowWalk2D[walk] displays a two-*)
(*Dimensional random walk connecting each site with a line.*)
(*Any Graphics options can be passed to ShowWalk2D. E.g.,*)
(*ShowWalk2D[walk,Background->GrayLevel[0]] to produce*)
(*a black background.";*)


(* ::Input:: *)
(*ShowPointWalk2D::usage="ShowPointWalk2D[walk,opts]*)
(*displays a two-dimensional walk with each site shown as*)
(*a point. Graphics options can be passed to ShowPointWalk2D.*)
(*E.g., ShowWalk2D[walk,Background->GrayLevel[0]] to*)
(*produce a black background.";*)


(* ::Input:: *)
(*ShowHistoryWalk2D::usage="ShowHistoryWalk2D[walk,opts]*)
(*Displays a two-dimensional random walk with each site shown*)
(*as a point colored according to its history in the walk.*)
(*Graphics options can be passed to ShowHistoryWalk.";*)


(* ::Input:: *)
(*ShowWalk3D::usage="ShowWalk3D[walk] displays a three-*)
(*Dimensional random walk connecting each site with a line.*)
(*Any Graphics3D options can be passed to ShowWalk3D. E.g.,*)
(*ShowWalk3D[walk,Boxed->False] to inhibit the display of*)
(*a bounding box.";*)


(* ::Input:: *)
(*ShowCubeWalk3D::usage="ShowCubeWalk3D[walk] displays*)
(*a three-dimensional random walk displaying each site as*)
(*a cube. Any Graphics3D options can be passed to*)
(*ShowCubeWalk3D. E.g., ShowCubeWalk3D[walk,Boxed->False]*)
(*to inhibit the display of a bounding box.";*)


(* ::Input:: *)
(*AnimateWalk2D::usage="AnimateWalk2D[walk,opts]*)
(*creates an animation of a two-dimensional random walk.*)
(*A red ball will be seen to move to the current position*)
(*in the walk to aid in visualizing the animation.";*)


(* ::Input:: *)
(*Options[Walk2D]={LatticeWalk->True}*)


(* ::Input:: *)
(*Begin["`Private`"]*)


(* ::Input:: *)
(*Walk1D[n_]:=*)
(*FoldList[Plus,0,Table[(-1)^Random[Integer],{n}]]*)


(* ::Input:: *)
(*Walk2D[n_,opts___]:=Module[{lattice},*)
(*lattice=LatticeWalk/.{opts}/.Options[Walk2D];*)
(*If[lattice==True,*)
(*FoldList[Plus,{0,0},*)
(*{{0,1},{1,0},{0,-1},{-1,0}}[[*)
(*Table[Random[Integer,{1,4}],{n}]]]],*)
(*FoldList[Plus,{0,0},*)
(*Map[({Sin[#],Cos[#]})&,*)
(*Table[Random[Real,{0,N[2Pi]}],{n}]]*)
(*]]]*)


(* ::Input:: *)
(*Walk3D[n_]:=FoldList[Plus,{0,0,0},*)
(*{{-1,1,1},{-1,-1,1},{1,-1,1},{1,1,1},*)
(*{-1,1,-1},{-1,-1,-1},{1,-1,-1},{1,1,-1}}[[Table[*)
(*Random[Integer,{1,8}],{n}]]]]*)


(* ::Input:: *)
(*SquareDistance[walk_List]:=*)
(*Apply[Plus,(Last[walk]-First[walk])^2]*)


(* ::Input:: *)
(*MeanSquareDistance[n_Integer,m_Integer]:=*)
(*N[Sum[SquareDistance[Walk2D[n]],{m}]/m]*)


(* ::Input:: *)
(*MeanSquareRadiusGyration[m_Integer,n_Integer]:=*)
(*Module[{},*)
(*squareRadiusOfGyration[s_Integer]:=*)
(*Module[{locs,cm,choices={{1,0},{-1,0},{0,1},{0,-1}}},*)
(*locs=FoldList[Plus,{0,0},*)
(*choices[[Table[Random[Integer,{1,4}],{s}]]]];*)
(*cm=N[Apply[Plus,locs]/(s+1)];*)
(*Apply[Plus,Flatten[(Transpose[locs]-cm)^2]]/(s+1)*)
(*];*)
(*N[Sum[SquareRadiusofGyration[n],{m}]/m]*)
(*]*)


(* ::Input:: *)
(*ShowWalk2D[coords_,opts___]:=*)
(*Show[Graphics[Line[coords],*)
(*opts,*)
(*AspectRatio->Automatic]]*)


(* ::Input:: *)
(*ShowPointWalk2D[coords_,opts___]:=*)
(*Module[{prwise,distances,colors},*)
(*prwise=Map[N[Sqrt[Apply[Plus,*)
(*(#[[1]]-#2[[2]])^2]]]&,*)
(*prwise];*)
(*colors=Map[Hue,distances/Max[distances]];*)
(*Show[Graphics[Transpose[{colors,Map[Point,coords]}],*)
(*opts,AspectRatio->Automatic]]]*)


(* ::Input:: *)
(*ShowHistoryWalk2D[coords_,opts___]:=*)
(*Module[{len=Length[coords],points,colors},*)
(*points=Map[Point,coords];*)
(*colors=Map[Hue,Range[len]/len];*)
(*Show[Graphics[{PointSize[.01],*)
(*Transpose[{colors,points}]},*)
(*opts,AspectRatio->Automatic]]]*)


(* ::Input:: *)
(*ShowWalk3D[coords_,opts___]:=*)
(*Show[Graphics3D[Line[coords],*)
(*opts,AspectRatio->Automatic]]*)


(* ::Input:: *)
(*ShowCubeWalk3D[walk_,opts___]:=*)
(*Show[Graphics[Map[Cuboid,walk],*)
(*opts,AspectRatio->Automatic]]*)


(* ::Input:: *)
(*AnimateWalk2D[coords_,opts___]:=*)
(*Scan[Show[Graphics[{*)
(*{RGBColor[1,0,0],PointSize[.025],*)
(*Point[coords[[#]]]},*)
(*Line[Take[coords,#]]}],*)
(*opts,AspectRatio->Automatic,*)
(*PlotRange->Map[{Min[#]-.2,Max[#]+.2}&,*)
(*Transpose[coords]]]&,*)
(*Range[2,Length[coords]]]*)


(* ::Input:: *)
(*End[]*)


(* ::Input:: *)
(*EndPackage*)
