Uses    Math;

Const   ginp='saw.inp';
        gout='saw.out';
        maxn=110;

Type    point= record x,y:int64; end;
        p2=record x,y:extended; end;

Var     na,nb,st:longint;
        res:extended;
        a,b:array[0..maxn] of point;
        da,db:array[0..maxn] of p2;

Function Area(a,b,c:point):int64;
Begin
        area:=(b.x-a.x)*(b.y+a.y);
        area:=area+(c.x-b.x)*(c.y+b.y);
        area:=area+(a.x-c.x)*(a.y+c.y);
End;

Procedure Enter;
Var     i,n:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                readln(a[i].x,a[i].y);
                if a[i].x=0 then break;
        end;
        na:=i;
        nb:=n-na+2; b[1]:=a[na];
        for i:=2 to nb do readln(b[i].x,b[i].y);
End;

Procedure Chuanhoaa;
Var     i,nn:longint;
Begin
        nn:=2;
        for i:=3 to na do
        begin
                while (nn>=2) and (area(a[nn-1],a[nn],a[i])>=0) do dec(nn);
                inc(nn); a[nn]:=a[i];
        end;
        na:=nn;
End;

Procedure Chuanhoab;
Var     i,nn:longint;
Begin
        nn:=2;
        for i:=3 to nb do
        begin
                while (nn>=2) and (area(b[nn-1],b[nn],b[i])>=0) do dec(nn);
                inc(nn); b[nn]:=b[i];
        end;
        nb:=nn;
End;

Function Calc(i,j:longint):extended;
Begin
        calc:=min(da[i].x,db[i].x)*min(da[j].y,db[j].y);
End;

Procedure Process;
Var     i,j:longint;
Begin
        res:=0;
        for i:=2 to na do
        begin
                da[i].x:=a[i].y/(a[i].y-a[i-1].y)*(a[i].x-a[i-1].x)-a[i].x;
                da[i].y:=a[i-1].x/(a[i-1].x-a[i].x)*(a[i].y-a[i-1].y)+a[i-1].y;
        end;
        for i:=2 to nb do
        begin
                db[i].x:=b[i-1].y/(b[i-1].y-b[i].y)*(b[i].x-b[i-1].x)+b[i-1].x;
                db[i].y:=b[i].x/(b[i].x-b[i-1].x)*(b[i-1].y-b[i].y)+b[i].y;
        end;
        j:=2;
        for i:=na downto 2 do
        begin
                while (j<=nb) and (db[j].y>da[i].y) do inc(j);
                res:=max(res,calc(i,j-1));
                if j<=nb then res:=max(res,calc(i,j));
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        while st>0 do
        begin
                Enter;
                Chuanhoaa;
                Chuanhoab;
                Process;
                writeln(res/2:0:6);
                dec(st);
        end;
        Close(input); Close(output);
End.
