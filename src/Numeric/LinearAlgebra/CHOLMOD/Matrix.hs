{-# LANGUAGE GADTs               #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Numeric.LinearAlgebra.CHOLMOD.Matrix
  (
    
  ) where

import qualified Foreign.Ptr as F
import qualified Foreign.ForeignPtr as F
import qualified Foreign.C.Types as F
--import Foreign.Marshal.Array (withArray)

-- kinds of Cholmod matrices (and vectors)
data MType = Dense | Sparse | Triplet

-- holder of foreign ptr to cholmod matrix
data Matrix (t :: MType) (a :: Type) where
  DenseM :: F.ForeignPtr a -> Matrix Dense a
  SparseM :: F.ForeignPtr a -> Matrix Sparse a
  TripletM :: F.ForeignPtr a -> Matrix Triplet a

-- conversions 
data DenseIso mt a where
  DenseIso :: (mt a -> Matrix Dense a) -> (Matrix Dense a -> mt a) -> DenseOps mt a

data SparseIso mt a where
  SparseIso :: (mt a -> Matrix Sparse a) -> (Matrix Sparse a -> mt a) -> SparseOps mt a

data TripletIso mt a where
  TripletIso :: (mt a -> Matrix Triplet a) -> (Matrix Triplet a -> mt a) -> TripletOps mt a

  
