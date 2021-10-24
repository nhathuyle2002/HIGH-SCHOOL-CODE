type    matrix= array[1..3,1..3] of int64;

const   ginp='ss.inp';
        gout='ss.out';
        base=15111992;
        dv:matrix =((1,0,0),(0,1,0),(0,0,1));

var     n:longint;
        s1,s2,s:ansistring;
        tc,tl:longint;
        f:array[0..101] of int64;
        dc,dl,d:matrix;
        res:int64;

procedure enter;
begin
        readln(n);
        readln(s1);
        readln(s2);
        read(s);
end;

operator * (a,b:matrix) c:matrix;
var     i,j,k:longint;
begin
        fillchar(c,sizeof(c),0);
        for i:=1 to 3 do
                for j:=1 to 3 do
                        for k:=1 to 3 do
                                c[i,j]:=(c[i,j]+a[i,k]*b[k,j]) mod base;
end;

function pow(k:longint):matrix;
var     c:matrix;
begin
        if k=0 then exit(dv);
        c:=pow(k shr 1);
        pow:=c*c;
        if k and 1=1 then pow:=pow*d;
end;

function tk(ss:ansistring):longint;
var     i:longint;
begin
        tk:=0;
        for i:=1 to length(ss)-length(s)+1 do
                if copy(ss,i,length(s))=s then inc(tk);
end;

procedure process;
var     i,ii,i0,tmp:longint;
        ss:ansistring;
        c:matrix;
begin
        f[1]:=tk(s1);
        f[2]:=tk(s2);
        for i:=3 to n do
        begin
                if length(s2)<length(s)-1 then ii:=length(s2) else ii:=length(s)-1;
                ss:='';
                for i0:=1 to ii do ss:=s2[length(s2)-i0+1]+ss;
                if length(s1)<length(s)-1 then ii:=length(s1) else ii:=length(s)-1;
                for i0:=1 to ii do ss:=ss+s1[i0];
                tmp:=tk(ss);
                if i mod 2=1 then tl:=tmp else tc:=tmp;
                f[i]:=f[i-1]+f[i-2]+tmp;
                ss:=s2+s1;s1:=s2;s2:=ss;
                if (i>4) and (length(s1)>=2*length(s)) and ((n-i) mod 2=0) then break;
        end;
        if i>=n then
        begin
                write(f[n]);
                exit;
        end;
        dc[1,1]:=1;dc[1,2]:=1;dc[2,1]:=1;dc[3,3]:=1;dl:=dc;
        dc[1,3]:=tc;dl[1,3]:=tl;
        if i mod 2=1 then d:=dc*dl else d:=dl*dc;
        c:=pow((n-i) div 2);
        res:=(f[i]*c[1,1]+f[i-1]*c[1,2]+c[1,3]) mod base;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
