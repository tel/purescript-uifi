
module UiFi.Node.Zipper where

import UiFi.Node (Node (Node, Text), NodeData)
import Data.List (List (Nil, Cons), reverse)
import Prelude ((++))
import Data.Maybe (Maybe (Nothing, Just))

type Step = 
  { lefts :: List Node
  , rights :: List Node
  , dat :: NodeData
  }

data Zipper = Zipper (List Step) Node

here :: Zipper -> Node
here (Zipper _ n) = n

on :: Node -> Zipper
on n = Zipper Nil n

off :: Zipper -> Node
off z =
  case up z of
    Nothing -> here z
    Just z' -> off z'

left :: Zipper -> Maybe Zipper
left (Zipper Nil _) = Nothing
left (Zipper (Cons { lefts: Nil } ss) n) = Nothing
left (Zipper (Cons s@{ lefts: Cons ln lefts, rights, dat } ss) n) = 
  Just (Zipper (Cons { lefts, rights: Cons n rights, dat } ss) ln)

right :: Zipper -> Maybe Zipper
right (Zipper Nil _) = Nothing
right (Zipper (Cons { rights: Nil } ss) n) = Nothing
right (Zipper (Cons s@{ rights: Cons rn rights, lefts, dat } ss) n) = 
  Just (Zipper (Cons { rights, lefts: Cons n lefts, dat } ss) rn)

down :: Zipper -> Maybe Zipper
down (Zipper steps (Text _)) = Nothing
down (Zipper steps (Node dat cs)) = 
  case cs of
    Nil -> Nothing
    Cons n ns -> 
    Just (Zipper (Cons { lefts: Nil, rights: ns, dat } steps) n)

up :: Zipper -> Maybe Zipper
up (Zipper Nil _) = Nothing
up (Zipper (Cons { lefts, rights, dat } steps) n)
  = Just (Zipper steps (Node dat (reverse lefts ++ Cons n rights)))
