const   fi='xephcn.inp';
        fo='xephcn.out';
        maxn=20003;
        oo=trunc(1e9);
var     w,h     :array[0..maxn] of longint;
        a,b     :array[0..maxn] of longint;
        i,j,n   :longint;
        res     :longint;
        t,tt    :longint;
procedure enter;
begin
        fillchar(a,sizeof(a),0);
        fillchar(b,sizeof(b),0);
        fillchar(w,sizeof(w),0);
        fillchar(h,sizeof(h),0);
        readln(n);
        for i:=1 to n do readln(w[i],h[i]);
end;
procedure swap(var x,y:longint);
var     tg      :longint;
begin
        tg:=x;x:=y;y:=tg;
end;
procedure qs(l,r:longint);
var     x,y,i,j :longint;
begin
        i:=l;j:=r;
        x:=h[(l+r) div 2];
        y:=w[(l+r) div 2];
        repeat
                while (x>h[i]) or ((x=h[i]) and (y<w[i])) do inc(i);
                while (x<h[j]) or ((x=h[j]) and (y>w[j])) do dec(j);
                if i<=j then
                        begin
                                swap(h[i],h[j]);
                                swap(w[i],w[j]);
                                inc(i);dec(j);
                        end;
        until i>j;
        if i<r then qs(i,r);
        if j>l then qs(l,j);
end;
function tim(r,x:longint):longint;
var     d,c,g   :longint;
begin
        d:=0;c:=r;
        g:=(d+c) div 2;
        while (g<>d) and (g<>c) do
                begin
                        if b[g]>x then c:=g else d:=g;
                        g:= (d+c) div 2;
                end;
        for g:=c downto d do
                if x>=b[g] then exit(g);
end;
procedure process;
var     tam     :longint;
begin
        qs(1,n);
        a:=w;
        b[0] := -oo;
        b[1] := a[n];
        res :=1;
        for i:=n-1 downto 1 do
                begin
                        tam := tim(res,a[i]);
                        if tam+1>res then
                                begin
                                        res := res+1;
                                        b[res] := a[i];
                                end
                                else
                                if b[tam+1]>a[i] then b[tam+1]:=a[i];
                end;
end;
procedure print;
begin
        writeln(output,res);
end;
begin
assign(input,fi);reset(input);
assign(output,fo);rewrite(output);
        enter;
        process;
        print;
close(input);close(output);
end.
