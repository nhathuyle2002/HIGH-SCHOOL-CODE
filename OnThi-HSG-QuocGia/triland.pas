Uses    Math;

Const   ginp='triland.inp';
        gout='triland.out';
        maxn=3001;

Type    point= record x,y:int64; end;

Var     n,nb:longint;
        res:int64;
        a,b:array[0..maxn] of point;

Procedure Swap(var a,b:point); inline;
Var     tmp:point;
Begin
        tmp:=a; a:=b; b:=tmp;
End;

Function Stg(x,y,z:point):int64; inline;
Begin
        stg:=(y.x-x.x)*(y.y+x.y)+(z.x-y.x)*(z.y+y.y)+(x.x-z.x)*(x.y+z.y);
End;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t:point;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while stg(a[i],a[1],t)>0 do inc(i);
                while stg(a[j],a[1],t)<0 do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i,pi:longint;
Begin
        readln(n);
        pi:=1;
        for i:=1 to n do
        begin
                readln(a[i].x,a[i].y);
                if (a[i].x<a[pi].x) or ((a[i].x=a[pi].x) and (a[i].y<a[pi].y)) then pi:=i;
        end;
        swap(a[pi],a[1]);
        sort(2,n);
End;

Procedure Process;
Var     i,j,k:longint;
        s,s2:int64;
Begin
        nb:=0;
        for i:=1 to n do
        begin
                while (nb>=2) and (stg(b[nb-1],a[i],b[nb])<0) do dec(nb);
                inc(nb); b[nb]:=a[i];
        end;
        res:=0;
        for i:=1 to nb-2 do
        begin
                k:=i+2;
                for j:=i+1 to nb-1 do
                begin
                        s:=stg(b[k],b[j],b[i]);
                        while k<nb do
                        begin
                                s2:=stg(b[k+1],b[j],b[i]);
                                if s2<s then break;
                                inc(k); s:=s2;
                        end;
                        res:=max(res,s);
                end;
        end;
        write(res/2:0:1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
