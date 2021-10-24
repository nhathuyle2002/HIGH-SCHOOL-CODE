const
  tfi = 'count.inp';
  tfo = 'count.out';
var
        n,test: longint;
        res:int64 ;
(*--------------------------------*)
function Uc(x,Y:int64)  : int64;
  begin
        if x = 0 then exit(y);
        exit(uc(y mod x,x));
  end;
(*--------------------------------*)
procedure xuly;
var i,j,x,x2:longint;
begin
        x := trunc(sqrt(n));
        res := 0 ;
        for i := 1 to x do res := res + n div i ;
        x := x + 1 ;
        while x <= n do
            begin
               i := n div x;
               x2 := n div i ;
               res := res + int64(i) * (x2 - x + 1) ;
               x := x2 + 1;
            end ;
end;
(*--------------------------------*)
procedure process;
  var
        y,z:int64 ;
  begin
        read(test);
        while test > 0 do
         begin
                dec(test) ;
                read(n) ;
                xuly;
                y := int64(n) * n ;
                z := uc(res,y);
                writeln(res div z,'/',y div z) ;
         end;
  end;
(*--------------------------------*)
BEGIN
        assign(input,tfi) ;reset(input);
        assign(output,tfo) ; rewrite(output) ;
        process;
END.
