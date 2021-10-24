const   ginp='ss.inp';
        gout='ss.out';
        base=1000000;
        ch=32;

var     n,l:longint;
        a,b,c:array[0..6,0..31] of boolean;
        fr,bh:array[0..31] of longint;
        chl,res:int64;
        ff,fb:array[0..31] of int64;

procedure enter;
var     i,j:longint;
        s:string[30];
        ok:boolean;
begin
        readln(n,l);
        for i:=1 to 5 do
        begin
                readln(s);
                for j:=1 to l do
                        if s[j]='#' then a[i,j]:=true;
        end;
        for i:=1 to 5 do
        begin
                readln(s);
                for j:=1 to l do
                        if s[j]='#' then b[i,j]:=true;
        end;
        ok:=false;
        for i:=1 to 5 do
                for j:=1 to l do
                        if a[i,j]<>b[i,j] then ok:=true;
        if not ok then
        begin
                write(0);
                res:=-1;
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,jj:longint;
        ok:boolean;
begin
        fr[0]:=0;bh[0]:=0;
        for j:=l downto 2 do
        begin
                ok:=true;fr[l-j+1]:=fr[l-j];
                for jj:=j to l do
                        for i:=1 to 5 do
                                if b[i,jj]<>a[i,l-jj+1] then ok:=false;
                if ok then inc(fr[l-j+1]);
        end;
        for j:=l downto 2 do
        begin
                ok:=true;bh[l-j+1]:=bh[l-j];
                for jj:=j to l do
                        for i:=1 to 5 do
                                if a[i,jj]<>b[i,l-jj+1] then ok:=false;
                if ok then inc(bh[l-j+1]);
        end;
        chl:=1;
        for i:=1 to l do chl:=(chl*ch) mod base;
        ff[0]:=1;
        for i:=1 to l-1 do ff[i]:=(ff[i-1]*ch) mod base;
        for i:=l to n-l+1 do
                ff[i]:=(ff[i-1]*ch-ff[i-l]+base) mod base;
        fb[n+1]:=1;
        for i:=n downto n-l+2 do fb[i]:=(fb[i+1]*ch) mod base;
        for i:=n-l+1 downto l do
                fb[i]:=(fb[i+1]*ch-fb[i+l]+base) mod base;
        for i:=l to n do
                res:=(res+(ff[i-l]-fr[min(l-1,i-l)])*(fb[i+1]-bh[min(l-1,n-i)])) mod base;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        if res>-1 then
        begin
                process;
                c:=a;a:=b;b:=c;
                process;
                write(res);
        end;
        close(input);close(output);
end.
