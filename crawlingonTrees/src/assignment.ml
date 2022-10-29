type tree = Empty 
          | Node of int * tree * tree
type command = Left | Right | Up | New of int | Delete | Push | Pop

(* print a graphical representation (dot) of a binary tree (2. argument) to a file (1. argument) *)
let print_tree filename btree = 
  let file = open_out filename in
  Printf.fprintf file "digraph Tree {\n";
  let rec print next_id = function Empty -> 
    Printf.fprintf file "\tn%d[shape=rectangle,label=\"\"];\n" next_id; next_id + 1, next_id
  | Node (x, l, r) ->
    let node_id = next_id in
    Printf.fprintf file "\tn%d[label=\"%d\"];\n" node_id x;
    let next_id, lid = print (next_id + 1) l in
    let next_id, rid = print next_id r in 
    (Printf.fprintf file "\tn%d -> n%d[label=\"L\"];\n" node_id lid);
    (Printf.fprintf file "\tn%d -> n%d[label=\"R\"];\n" node_id rid);
    next_id, node_id
  in
  ignore(print 0 btree);
  Printf.fprintf file "}";
  close_out file


let crawl cmds tree =
  let currenTree = tree in
  let motherStack = [] in
  let directions = [] in 
  let treeStack = [] in
  
  let rec crawling cmds tree currenTree treeStack motherStack directions =  
    let taker stack = 
      match stack with
      |[] -> Empty
      |x::xs -> x in
  
    let popping stack = 
      match stack with
      |[] -> []
      |x::xs -> xs in
  
    let pusher cmds tree currenTree treeStack motherStack directions = 
      let newTreeStack = currenTree :: treeStack in
      crawling cmds tree currenTree newTreeStack motherStack directions in
  
    let popper cmds tree currenTree treeStack motherStack directions =
      let newCurrenTree = taker treeStack in
      let newTreeStack = popping treeStack in
      let rec replacer cmds tree currenTree treeStack motherStack directions = 
        let rec replace tree currenTree treeStack motherStack directions = 
          let mother = taker motherStack in
          let newMotherStack = popping motherStack in
          match mother with
          |Empty -> currenTree
          |Node (integer,t1,t2) -> match directions with
            |[] -> currenTree
            |x::xs -> match x with
              |Left -> replace tree (Node (integer,currenTree,t2)) treeStack newMotherStack xs
              |Right -> replace tree (Node (integer,t1,currenTree)) treeStack newMotherStack xs in
        let newTree = replace tree currenTree treeStack motherStack directions in
        crawling cmds newTree currenTree treeStack motherStack directions in
      replacer cmds tree newCurrenTree newTreeStack motherStack directions in
  
    let upper cmds tree currenTree treeStack motherStack directions = 
      let mother = taker motherStack in
      let newMotherStack = popping motherStack in
      match directions with
      |[] -> crawling cmds tree mother treeStack newMotherStack directions
      |x::xs -> crawling cmds tree mother treeStack newMotherStack xs in
  
    let lefter cmds tree currenTree treeStack motherStack directions = 
      match currenTree with
      |Empty -> crawling cmds tree currenTree treeStack motherStack directions
      |Node (integer,t1,t2) -> crawling cmds tree t1 treeStack (currenTree::motherStack) (Left::directions) in
  
    let righter cmds tree currenTree treeStack motherStack directions = 
      match currenTree with
      |Empty -> crawling cmds tree currenTree treeStack motherStack directions
      |Node (integer,t1,t2) -> crawling cmds tree t2 treeStack (currenTree::motherStack) (Right::directions) in
    
  
  
    let rec replacer cmds tree currenTree treeStack motherStack directions = 
      let rec replace tree currenTree treeStack motherStack directions = 
        let mother = taker motherStack in
        let newMotherStack = popping motherStack in
        match mother with
        |Empty -> currenTree
        |Node (integer,t1,t2) -> match directions with
          |[] -> currenTree
          |x::xs -> match x with
            |Left -> replace tree (Node (integer,currenTree,t2)) treeStack newMotherStack xs
            |Right -> replace tree (Node (integer,t1,currenTree)) treeStack newMotherStack xs in
      let newTree = replace tree currenTree treeStack motherStack directions in
      crawling cmds newTree currenTree treeStack motherStack directions in
  
  
    
    
    match (cmds,currenTree) with
    |([],currenTree) -> tree
    |(x::xs,Empty) -> (match x with
        |New integer -> replacer xs tree (Node (integer , Empty , Empty )) treeStack motherStack directions
        |Delete -> replacer xs tree Empty treeStack motherStack directions
        |Push -> pusher xs tree currenTree treeStack motherStack directions
        |Pop -> popper xs tree currenTree treeStack motherStack directions
        |Up -> upper xs tree currenTree treeStack motherStack directions
      )
    |(x::xs,Node (integer,t1,t2)) -> (match x with
        |New integer -> replacer xs tree (Node (integer , Empty , Empty )) treeStack motherStack directions
        |Delete -> replacer xs tree Empty treeStack motherStack directions
        |Push -> pusher xs tree currenTree treeStack motherStack directions
        |Pop -> popper xs tree currenTree treeStack motherStack directions
        |Up -> upper xs tree currenTree treeStack motherStack directions
        |Left -> lefter xs tree currenTree treeStack motherStack directions
        |Right -> righter xs tree currenTree treeStack motherStack directions
      )
  in
  crawling cmds tree currenTree treeStack motherStack directions ;;

let t_l = Node (2, Node (1, Empty, Empty), Node (3, Empty, Empty));;
let t_r = Node (6, Node (5, Empty, Empty), Node (7, Empty, Empty));;
let tree = Node (4, t_l , t_r);;
crawl [Left; Push; Right; Pop] tree;;

crawl [Left; Right; Up; Left; Up; Up; New 3] tree;;
 