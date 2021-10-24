const   fi='CWORDS.INP';
        fo='CWORDS.OUT';
        maxn=100000;
var     n:longint;
        kq,tmp,thua:Qword;
        a,d:array['A'..'Z','A'..'Z'] of longint;
        f:array[1..4,1..maxn] of Qword;
        gt:array[1..4] of Qword;
procedure       nhap;
var     f:Text;
        i:longint;
        x:string;
begin
        assign(f,fi); reset(f);
        readln(f,n);
        for i:=1 to n do
        begin
                readln(f,x);
                inc(a[x[1],x[length(x)]]);
        end;
        close(f);
end;
procedure       tinh(x,y:char);
begin
        if a[x,y]=100000 then
                begin
                        thua:=thua*1000;
                        f[d[x,y],a[x,y]]:=f[d[x,y],a[x,y]] div 1000;
                end;
        tmp:=Qword(tmp*gt[d[x,y]]*f[d[x,y],a[x,y]]);
        d[x,y]:=0;
end;
procedure       xuli;
var     i,j:longint;
        x,y,u,v:char;
begin
        for i:=1 to 4  do
                for j:=1 to n do
                if j>=i then
                begin
                        if i=1 then f[i,j]:=j
                        else f[i,j]:=f[i-1,j-1]+f[i,j-1];
                end;
        kq:=0;
        thua:=1;
        gt[1]:=1;
        for i:=2 to 4  do
                gt[i]:=gt[i-1]*i;
        for x:='A' to 'Z' do
        for y:='A' to 'Z' do
        if a[x,y]>0 then
        for u:='A' to 'Z' do
        if a[y,u]>0 then
        for v:='A' to 'Z' do
        if (a[x,v]>0) and (a[v,u]>0) then
        begin
                inc(d[x,y]);
                inc(d[y,u]);
                inc(d[v,u]);
                inc(d[x,v]);
                tmp:=1;
                if (d[x,y]>0) then
                        tinh(x,y);
                if (d[y,u]>0) then
                        tinh(y,u);
                if (d[v,u]>0) then
                        tinh(v,u);
                if (d[x,v]>0) then
                        tinh(x,v);
                kq:=kq+tmp;
        end;

end;
procedure       xuat;
var     g:Text;
        i:longint;
        s:string;
begin
        assign(g,fo); rewrite(g);
       // for i:=n-10 to n do writeln(g,f[4,i-1],' ',f[3,i-1],' ',f[4,i]);
        write(g,kq);
        str(thua,s);
        delete(s,1,1);
        write(g,s);
        close(g);
end;
begin
        nhap;
        xuli;
        xuat;
end.
