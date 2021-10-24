Const   ginp='flower.inp';
        gout='flower.out';

Type    Point= record x,y:int64; end;

Var     n,res:longint;
        p:array[1..3] of point;
        a:array[0..1001] of point;

Procedure Enter;
Var     i:longint;
Begin
        for i:=1 to 3 do readln(p[i].x,p[i].y);
        readln(n);
        for i:=1 to n do readln(a[i].x,a[i].y);
End;

Function Area(x,y,z:point):int64;
Begin
        area:=(y.x-x.x)*(y.y+x.y)+(z.x-y.x)*(z.y+y.y)+(x.x-z.x)*(z.y+x.y);
End;

Procedure Process;
Var     i:longint;
Begin
        writeln(abs(area(p[1],p[2],p[3]))/2:0:2);
        res:=0;
        for i:=1 to n do
                if ((area(p[1],p[2],a[i])<=0) and (area(p[2],p[3],a[i])<=0) and (area(p[3],p[1],a[i])<=0))
                or ((area(p[1],p[2],a[i])>=0) and (area(p[2],p[3],a[i])>=0) and (area(p[3],p[1],a[i])>=0)) then inc(res);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
