const   ginp='';
        gout='';

var     gi,go:text;
        s1,s2,s3,i,j,k,ans:longint;
        d:array[0..90] of longint;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,s1,s2,s3);
        fillchar(d,sizeof(d),0);
        for i:=1 to s1 do
                for j:=1 to s2 do
                        for k:=1 to s3 do inc(d[i+j+k]);
        ans:=1;
        for i:=2 to 90 do
                if d[i]>d[ans] then ans:=i;
        write(go,ans);
        close(gi);close(go);
end.

