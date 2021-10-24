const   ginp='chutieu.inp';
        gout='chutieu.out';

var     gi,go:text;
        n,m:longint;
        f2,f3,f:array[-2..1001] of ansistring;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
end;

procedure output;
begin
        close(gi);close(go);
end;

function cong(x,y:ansistring):ansistring;
var     i,nho,sum:longint;
begin
        while length(x)<length(y) do x:='0'+x;
        while length(y)<length(x) do y:='0'+y;
        nho:=0;
        cong:='';
        for i:=length(x) downto 1 do
        begin
                sum:=ord(x[i])+ord(y[i])-96+nho;
                nho:=sum div 10;
                cong:=chr(sum mod 10+48)+cong;
        end;
        if nho=1 then cong:='1'+cong;
end;

function nhan(x,y:ansistring):ansistring;
var     i,j,sum,nho,dem:longint;
        tmp:ansistring;
begin
        nhan:='0';nho:=0;dem:=-1;
        for i:=length(x) downto 1 do
        begin
                inc(dem);tmp:='';
                for j:=1 to ord(x[i])-48 do tmp:=cong(tmp,y);
                for j:=1 to dem do tmp:=tmp+'0';
                nhan:=cong(nhan,tmp);
        end;
end;

procedure cclt;
var     i:longint;
begin
        f2[1]:='1';f2[2]:='2';f2[3]:='3';
        f3[1]:='1';f3[2]:='2';f3[3]:='4';
        f[1]:='0';f[2]:='0';f[3]:='1';
        for i:=4 to 500 do
        begin
                f2[i]:=cong(f2[i-1],f2[i-2]);
                f3[i]:=cong(f3[i-1],cong(f3[i-2],f3[i-3]));
                f[i]:=cong(cong(f[i-1],f[i-2]),f2[i-3]);
        end;
end;

procedure process;
var     i:longint;
        tmp:ansistring;
begin
        while not(eof(gi)) do
        begin
                readln(gi,m,n);
                tmp:=nhan(nhan(f3[m],f3[n]),nhan(f[n],f2[m]));
                writeln(go,tmp);
        end;
end;

begin
        cclt;
        input;
        process;
        output;
end.










