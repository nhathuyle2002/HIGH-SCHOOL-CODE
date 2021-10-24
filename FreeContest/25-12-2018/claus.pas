Const   ginp='';//claus.inp';
        gout='';//claus.out';
        maxn=15;
        oo=trunc(1e8);

Type    point= record x,y,w:longint; end;

Var     n,s,res,ires,xres:longint;
        a:array[0..maxn] of point;
        f:array[0..1 shl maxn-1,0..maxn] of real;
        t:array[0..1 shl maxn-1,0..maxn] of longint;

Function Dis(x,y:point):real;
Begin
        dis:=sqrt(sqr(x.x-y.x)+sqr(x.y-y.y));
End;

Function Getb(i,x:longint):longint;
Begin
        getb:=x shr (i-1) and 1;
End;

Function Daob(i,x:longint):longint;
Begin
        daob:=x xor (1 shl (i-1));
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,s);
        for i:=1 to n do readln(a[i].x,a[i].y,a[i].w);
        a[0].x:=0; a[0].y:=0;
End;

Procedure Try(cou,x,i:longint);
Begin
        if cou=0 then exit;
        write(i,' ');
        try(cou-1,daob(i,x),t[x,i]);
End;

Procedure Process;
Var     x,i,j,y,cou:longint;
Begin
        res:=0; ires:=0; xres:=0;
        for x:=1 to 1 shl n-1 do
        begin
                cou:=0;
                for i:=1 to n do
                        if getb(i,x)=1 then inc(cou);
                for i:=1 to n do
                begin
                        f[x,i]:=oo;
                        if getb(i,x)=1 then
                        begin
                                y:=daob(i,x);
                                if y=0 then
                                begin
                                        t[x,i]:=0;
                                        f[x,i]:=dis(a[0],a[i])+a[i].w;
                                end else
                                for j:=1 to n do
                                if (getb(j,y)=1) and (f[x,i]>f[y,j]+dis(a[j],a[i])+a[i].w) then
                                begin
                                        t[x,i]:=j;
                                        f[x,i]:=f[y,j]+dis(a[j],a[i])+a[i].w;
                                end;
                        end;
                        if (cou>res) and (f[x,i]+dis(a[i],a[0])<=s) then
                        begin
                                res:=cou;
                                ires:=i;
                                xres:=x;
                        end;
                end;
        end;
        writeln(res);
        try(res,xres,ires);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
