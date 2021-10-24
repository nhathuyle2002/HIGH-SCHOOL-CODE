type    bignum= array[0..500] of longint;

const   ginp='ss.inp';
        gout='ss.out';
        base=round(1e9);

var     n:longint;
        s1,s2,s:ansistring;
        tc,tl:bignum;
        f:array[0..1010] of bignum;

procedure enter;
begin
        readln(n);
        readln(s1);
        readln(s2);
        read(s);
end;

function tk(ss:ansistring):longint;
var     i:longint;
begin
        tk:=0;
        for i:=1 to length(ss)-length(s)+1 do
                if copy(ss,i,length(s))=s then inc(tk);
end;

operator + (a,b:bignum) c:bignum;
var     i,nho:longint;
begin
        if a[0]<b[0] then c[0]:=b[0] else c[0]:=a[0];
        nho:=0;
        for i:=1 to c[0] do
        begin
                if i>a[0] then a[i]:=0;
                if i>b[0] then b[i]:=0;
                c[i]:=a[i]+b[i]+nho;
                if c[i]>=base then
                begin
                        c[i]:=c[i]-base;
                        nho:=1;
                end else nho:=0;
        end;
        if nho>0 then
        begin
                inc(c[0]);
                c[c[0]]:=nho;
        end;
end;

procedure process;
var     i,ii,i0:longint;
        ss:ansistring;
        tmp:bignum;
begin
        f[1,0]:=1;f[1,1]:=tk(s1);
        f[2,0]:=1;f[2,1]:=tk(s2);
        for i:=3 to n do
        begin
                if length(s2)<length(s)-1 then ii:=length(s2) else ii:=length(s)-1;
                ss:='';
                for i0:=1 to ii do ss:=s2[length(s2)-i0+1]+ss;
                if length(s1)<length(s)-1 then ii:=length(s1) else ii:=length(s)-1;
                for i0:=1 to ii do ss:=ss+s1[i0];
                tmp[0]:=1;tmp[1]:=tk(ss);
                if i mod 2=1 then tl:=tmp else tc:=tmp;
                f[i]:=f[i-1]+f[i-2]+tmp;
                ss:=s2+s1;s1:=s2;s2:=ss;
                if (i>4) and (length(s1)>=2*length(s)) then break;
        end;
        ii:=i;
        for i:=ii+1 to n do
                if i mod 2=0 then f[i]:=f[i-1]+f[i-2]+tl
                else f[i]:=f[i-1]+f[i-2]+tc;
        write(f[n,f[n,0]]);
        for i:=f[n,0]-1 downto 1 do
        begin
                str(f[n,i],ss);
                while length(ss)<9 do ss:='0'+ss;
                write(ss);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
