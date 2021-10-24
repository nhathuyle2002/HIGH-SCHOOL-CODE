uses math;
const fi = 'rail.inp';
        o = trunc(1e9);

type data = record
        gt, vt:longint;
        end;

var
        dd:array[1..5100] of longint;
        f:text;
        t,i,j,b,ta,tb,n,m,k,x1,y1,x2,y2:longint;
        xa:array[1..4] of longint = (0,1,-1,0);
        xb:array[1..4] of longint = (1,0,0,-1);
        c:string = '+*';
        a:array[0..100100] of longint;

procedure swap(var a,b:data) ;
var   t:data;
begin
        t:=a; a:=b; b:=t;
end;
procedure swap(var a,b:longint);
var   t:longint;
begin
        t:=a; a:=b; b:=t;
end;
{
procedure qs(l, r:longint);
var     i,j : longint;
        x:data;
begin
        i:= l; j:= r; x:=a[random(r-l+1)+l];
        repeat
                while a[i].gt < x.gt do inc(i);
                while a[j].gt > x.gt do dec(j);
                if i<=j then begin swap(a[i], a[j]);
                                   inc(i); dec(j);
                             end;
        until i>j;
        if i < r then qs(i, r);
        if l < j then qs(l, j);
end;
}
function r(a:int64):int64;
begin
        exit(random(a)+1);
end;

procedure gentest;
var   n, h, y, m,a,b: longint;
        o:longint;
begin
        o:= trunc(1e1);
        writeln(f,18);
        for i:=1 to 18 do write(f,r(2*o)-o,' ');

end;

begin
        assign(f,fi); rewrite(f);
        randomize;

        gentest;


        close(f);
end.
