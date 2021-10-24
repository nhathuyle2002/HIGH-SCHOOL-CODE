Uses    Math;

Const   ginp='lines.inp';
        gout='lines.out';
        maxn=100010;

Type    point= record x,y:longint; end;
        line= record p1,p2:point; end;

Var     n:longint;
        a:array[0..maxn] of line;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        with a[i] do
                readln(p1.x,p1.y,p2.x,p2.y);
End;

Function InP(p:point; b:line):boolean;
Begin
        if (p.x<min(b.p1.x,b.p2.x)) or (p.x>max(b.p1.x,b.p2.x)) then exit(false);
        if (p.y<min(b.p1.y,b.p2.y)) or (p.y>max(b.p1.y,b.p2.y)) then exit(false);
        inp:=true;
End;

Function Area(x,y,z:point):int64;
Begin
        area:=int64(y.x-x.x)*(y.y+x.y)+int64(z.x-y.x)*(z.y+y.y)+int64(x.x-z.x)*(x.y+z.y);
        if area<0 then area:=-1 else
        if area>0 then area:=1;
End;

Procedure Process;
Var     i,j:longint;
        ok:boolean;
        s1,s2,s3,s4:int64;
Begin
        for i:=1 to n do
        begin
                for j:=i-1 downto 1 do
                begin
                        ok:=true;
                        s1:=area(a[i].p1,a[i].p2,a[j].p1); s2:=area(a[i].p1,a[i].p2,a[j].p2);
                        s3:=area(a[j].p1,a[j].p2,a[i].p1); s4:=area(a[j].p1,a[j].p2,a[i].p2);
                        if (s1*s2<0) and (s3*s4<0) then ok:=false else
                        if (s1=0) and (inp(a[j].p1,a[i])) then ok:=false else
                        if (s2=0) and (inp(a[j].p2,a[i])) then ok:=false else
                        if (s3=0) and (inp(a[i].p1,a[j])) then ok:=false else
                        if (s4=0) and (inp(a[i].p2,a[j])) then ok:=false;
                        if not ok then break;
                end;
                if not ok then break;
        end;
        if ok then write(-1) else write(i);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
