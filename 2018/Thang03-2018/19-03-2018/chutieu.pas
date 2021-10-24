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

function xuli(var x:ansistring):int64;
var     tmp:ansistring;
begin
        tmp:=copy(x,length(x)-8,9);
        val(tmp,xuli);
        delete(x,length(x)-8,9);
end;

function nhan(a,b:ansistring):ansistring;
var n,m,l,i,j,tmp,du:longint;
res:ansistring ;
begin
        res:=''; n:=length(A) ;m:=length(b);
        l:=m+n; du:=0;
        for i:=l downto 1 do
                begin
                tmp:=0;
                for j:=n downto 1 do
                if (i-j<=m) and (i-j>=1) then
                        tmp:=tmp+(ord(a[j])-48)*(ord(b[i-j])-48);
                tmp:=tmp+du;
                du:=tmp div 10;
                res:=chr(tmp mod 10 +48) + res;
                end;
        while (length(res)>1) and (res[1]='0') do
        delete(res,1,1);
        nhan:=res;
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










