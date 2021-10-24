type    matrix= array[0..100,0..100] of int64;

const   ginp='superseq.inp';
        gout='superseq.out';
        kk=666013;

var     n,h,k:longint;
        d:matrix;

operator * (a,b:matrix) c:matrix;
var     i,j,k:longint;
begin
        fillchar(c,sizeof(c),0);
        for i:=0 to h do
                for j:=0 to h do
                        for k:=0 to h do
                                c[i,j]:=(c[i,j]+a[i,k]*b[k,j]) mod kk;
end;

function lt(k:longint):matrix;
var     c:matrix;
begin
        if k=1 then exit(d);
        c:=lt(k shr 1);
        lt:=c*c;
        if k and 1=1 then lt:=lt*d;
end;

procedure main;
var     i,j,dd,cc:longint;
        c:matrix;
begin
        read(n,h,k);
        if n=1 then
        begin
                write(0);exit;
        end;
        for i:=0 to h do
        begin
                if i-k<0 then dd:=0 else dd:=i-k;
                if i+k>h then cc:=h else cc:=i+k;
                for j:=dd to cc do d[i,j]:=1;
        end;
        c:=lt(n-1);
        write(c[0,h]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
