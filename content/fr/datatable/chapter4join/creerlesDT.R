library(data.table)
set.seed(12345)
N <- 10
household <- data.table (hh_id=rep(1:N),
                 hh_name = LETTERS[1:N],
                 province = sample(c("EC", "L", "KZN", "MP", "WC"), N, TRUE),
                 house_type = sample(1:2, N, TRUE),
                 memb_1  = sample(c("Moses", "Pietr", "Stephen", "Liesl", "Marvel", "Justice"), N, TRUE),
                 memb_2  = sample(c("John", "Joe","Nofoto" , NA), N, TRUE),
                 memb_3  = sample(c("Inyoni", "Jabu",  NA), N, TRUE),
                 memb_4  = sample(c("Ulwazi", "Anele ",  NA, NA), N, TRUE) )

hh <- household[, .(hh_id, hh_name, province, house_type)]
hh[hh_id>=2, hh_id := hh_id + 1 ]

members <- melt(household, id.vars = 1, measure.vars = patterns("memb"), na.rm = TRUE)
members$id <- 1:nrow(members)
members$number_in_family <- rowidv(members, cols=c("hh_id"))
members[order(hh_id)]
members$age <- sample(25:70, nrow(members), TRUE)
members$education <- sample(1:7, nrow(members), TRUE)
members$off_farm <- sample(c(0,1), nrow(members), TRUE)
members$income <- sample(1000:10000, nrow(members), TRUE)

members <- members[order(hh_id),.(id, hh_id, name=value, no = number_in_family, age, education, off_farm, income)]
members$id <- 1:nrow(members)
members

members[hh_id==10, hh_id := 12]  # one id will not match
merge(hh, members, by="hh_id", all=TRUE)


# 2 not in hh but in members
# 11 in hh but no in members

hh[members, on="hh_id",  mult="first"]


fwrite(hh, file="content/households.csv")
fwrite(members, file="content/members.csv")


hh <- fread("https://raw.githubusercontent.com/djourd1/dataR/main/households.csv")
memb <- fread("https://raw.githubusercontent.com/djourd1/dataR/main/members.csv")
