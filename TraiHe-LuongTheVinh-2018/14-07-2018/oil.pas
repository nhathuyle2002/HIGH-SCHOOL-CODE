const   ginp='oil.inp';
        gout='oil.out';

type    save=record g,ma:longint;end;

var     m,n,k,res:longint;
        a:array[0..1010,0..1010] of longint;
        f1,f2,f3,f4:array[0..1010,0..1010] of save;
        fn,fd:array[0..1010,0..1010] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
end;

function max(x,y,z:longint):longint;
begin
        max:=x;
        if max<y then max:=y;
        if max<z then max:=z;
end;

procedure init;
var     i,j:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                begin
                        f1[i,j].g:=f1[i-1,j].g+f1[i,j-1].g-f1[i-1,j-1].g+a[i,j];
                        if (i>=k) and (j>=k) then
                        f1[i,j].ma:=max(f1[i,j].g-f1[i-k,j].g-f1[i,j-k].g+f1[i-k,j-k].g,f1[i-1,j].ma,f1[i,j-1].ma);
                end;
        for i:=1 to m do
                for j:=n downto 1 do
                begin
                        f2[i,j].g:=f2[i-1,j].g+f2[i,j+1].g-f2[i-1,j+1].g+a[i,j];
                        if (i>=k) and (j<=n-k+1) then
                        f2[i,j].ma:=max(f2[i,j].g-f2[i-k,j].g-f2[i,j+k].g+f2[i-k,j+k].g,f2[i-1,j].ma,f2[i,j+1].ma);
                end;
        for i:=m downto 1 do
                for j:=n downto 1 do
                begin
                        f3[i,j].g:=f3[i+1,j].g+f3[i,j+1].g-f3[i+1,j+1].g+a[i,j];
                        if (i<=m-k+1) and (j<=n-k+1) then
                        f3[i,j].ma:=max(f3[i,j].g-f3[i+k,j].g-f3[i,j+k].g+f3[i+k,j+k].g,f3[i+1,j].ma,f3[i,j+1].ma);
                end;
        for i:=m downto 1 do
                for j:=1 to n do
                begin
                        f4[i,j].g:=f4[i+1,j].g+f4[i,j-1].g-f4[i+1,j-1].g+a[i,j];
                        if (i<=m-k+1) and (j>=k) then
                        f4[i,j].ma:=max(f4[i,j].g-f4[i+k,j].g-f4[i,j-k].g+f4[i+k,j-k].g,f4[i+1,j].ma,f4[i,j-1].ma);
                end;
end;

procedure process;
var     i,j,s1,s2,s3,s4:longint;
begin
        res:=0;
        for i:=k to m-k do
                for j:=k to n-k do
                begin
                        s1:=f1[i,n].ma+f3[i+1,j+1].ma+f4[i+1,j].ma;
                        s2:=f2[m,j+1].ma+f4[i+1,j].ma+f1[i,j].ma;
                        s3:=f3[i+1,1].ma+f1[i,j].ma+f2[i,j+1].ma;
                        s4:=f4[1,j].ma+f2[i,j+1].ma+f3[i+1,j+1].ma;
                        res:=max(res,max(s1,s2,s3),s4);
                end;
end;

procedure init2;
var     i,j,kc:longint;
begin
        for i:=k to m do
                for j:=k to n do
                        fn[i-k+1,i]:=max(fn[i-k+1,i],f1[i,j].g-f1[i-k,j].g-f1[i,j-k].g+f1[i-k,j-k].g,0);
        for kc:=k+1 to m do
                for i:=kc to m do
                        fn[i-kc+1,i]:=max(0,fn[i-kc+1,i-1],fn[i-kc+2,i]);
        for j:=k to n do
                for i:=k to m do
                        fd[j-k+1,j]:=max(fd[j-k+1,j],f1[i,j].g-f1[i-k,j].g-f1[i,j-k].g+f1[i-k,j-k].g,0);
        for kc:=k+1 to n do
                for j:=kc to n do
                        fd[j-kc+1,j]:=max(0,fd[j-kc+1,j-1],fd[j-kc+2,j]);
end;

procedure process2;
var     i1,i2,j1,j2:longint;
begin
        for i1:=k to m-2*k do
                for i2:=i1+k to m-k do
                        res:=max(0,res,fn[1,i1]+fn[i1+1,i2]+fn[i2+1,m]);
        for j1:=k to n-2*k do
                for j2:=j1+k to n-k do
                        res:=max(0,res,fd[1,j1]+fd[j1+1,j2]+fd[j2+1,n]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        init;
        process;
        init2;
        process2;
        write(res);
        close(input);close(output);
end.
